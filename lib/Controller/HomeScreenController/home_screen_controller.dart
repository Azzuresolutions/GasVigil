import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gasvigil/App/Utils/common_function.dart';
import 'package:gasvigil/App/Utils/math_utils.dart';
import 'package:gasvigil/App/Utils/network_client.dart';
import 'package:gasvigil/App/Utils/pref_utils.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:gasvigil/App/presentation/theme/app_text_theme.dart';
import 'package:gasvigil/Model/dash_board_model.dart';
import 'package:gasvigil/Model/faq_model.dart';
import 'package:gasvigil/Model/get_devices_model.dart';
import 'package:gasvigil/Model/profile_model.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxInt currentPage = 0.obs;
  ProfileModel? profileModel;
  DashBoardModel? dashBoardModel;
  GetAlertsModel? getAlertsModel;
  GetDevicesModel? getDevicesModel;
  bool isShowProgress = false;
  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController idTextEditingController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode idFocusNode = FocusNode();
  List<GetDevicesModel> alldevices = [];
  List<GetAlertsModel> allAlerts = [];
  List<FaqModel> faQ = [];
  List<bool> isShowMore = [];
  dynamic aboutUs;
  dynamic contactUS;
  String fcmToken = "";
  bool nodataFound = false;

  apicallForDashBoard() {
    isShowProgress = true;
    update();
    NetworkClient.getInstance.makeApiCall(
      "http://gvapi.trovend.com/api/Dashboard",
      MethodType.get,
      params: {
        "email": profileModel?.email ?? "",
        // "email": "dharmikj.patel66@gmail.com"
      },
      successCallback: (response, message) {
        print(response);
        dashBoardModel = DashBoardModel.fromJson(response);
        isShowProgress = false;
        update();
      },
      failureCallback: (statusCode, message) {},
    );
  }

  apicallForGetAlerts() {
    allAlerts.clear();
    print(profileModel?.email ?? "");
    NetworkClient.getInstance.makeApiCall(
      "http://gvapi.trovend.com/api/alerts/getalerts",
      MethodType.get,
      params: {
        "email": profileModel?.email ?? "",
        // "email": "dharmikj.patel66@gmail.com"
      },
      successCallback: (response, message) {
        if (response.length != 0) {
          for (int i = 0; i < response.length; i++) {
            allAlerts.add(
              GetAlertsModel.fromJson(response[i]),
            );
          }
          update();
        } else {
          nodataFound = true;
          update();
        }
      },
      failureCallback: (statusCode, message) {},
    );
  }

  apicallForFaq() {
    NetworkClient.getInstance.makeApiCall(
      "http://gvapi.trovend.com/api/FAQs",
      MethodType.get,
      params: {},
      successCallback: (response, message) {
        print(response);
        for (int i = 0; i < response.length; i++) {
          if (response[i]['isActive'] == true) {
            faQ.add(
              FaqModel.fromJson(
                response[i],
              ),
            );
            isShowMore.add(false);
          }
        }
        update();
      },
      failureCallback: (statusCode, message) {},
    );
  }

  apicallForAddDevice() {
    NetworkClient.getInstance.makeApiCall(
      "http://gvapi.trovend.com/api/UserDevice",
      MethodType.post,
      params: {
        "deviceId": idTextEditingController.text,
        "userEmail": profileModel?.email ?? "",
        "name": nameTextController.text,
        "description": descriptionTextController.text
      },
      successCallback: (response, message) {
        print(response);
        CustomDialogs.getInstance.hideProgressDialog();
        Get.back();
        idTextEditingController.clear();
        nameTextController.clear();
        descriptionTextController.clear();
        apicallForDashBoard();
        apicallForGetAlerts();
        Get.snackbar("Success", "Successfully add device",
            backgroundColor: ColorConstants.tertiaryColor.withOpacity(0.5));
        update();
      },
      failureCallback: (statusCode, message) {},
    );
  }

  apicallForCheckNewDevice() {
    NetworkClient.getInstance.makeApiCall(
      "http://gvapi.trovend.com/api/Alerts/check-new-device",
      MethodType.get,
      params: {"deviceid": idTextEditingController.text},
      successCallback: (response, message) {
        print(response);
        if (response == "not-connected") {
          print("Failure");
          Get.back();
          Get.snackbar("Error", response,
              backgroundColor: Colors.red.withOpacity(0.4));
        } else {
          apicallForAddDevice();
        }
      },
      failureCallback: (statusCode, message) {
        Get.back();
        Get.snackbar("Error", message,
            backgroundColor: Colors.red.withOpacity(0.4));
      },
    );
  }

  apicallForGetDevice() {
    alldevices.clear();
    NetworkClient.getInstance.makeApiCall(
      "http://gvapi.trovend.com/api/UserDevice",
      MethodType.get,
      params: {
        "email": profileModel?.email ?? "",
        // "email": "dharmikj.patel66@gmail.com",
      },
      successCallback: (response, message) {
        print(response);
        if (response.length != 0) {
          for (int i = 0; i < response.length; i++) {
            alldevices.add(
              GetDevicesModel.fromJson(
                response[i],
              ),
            );
          }
          update();
        } else {
          nodataFound = true;
          update();
        }
      },
      failureCallback: (statusCode, message) {},
    );
  }

  apicallForFirebaseFcmToken() async {
    await FirebaseMessaging.instance
        .getToken()
        .then((value) => fcmToken = value!);
    await NetworkClient.getInstance.makeApiCall(
      "http://gvapi.trovend.com/api/FirebaseKeys",
      MethodType.post,
      params: {"emailId": profileModel?.email ?? "", "gcmKey": fcmToken},
      successCallback: (response, message) {
        print(response);
      },
      failureCallback: (statusCode, message) {},
    );
  }

  getUserData() {
    dynamic data =
        PrefUtils.getInstance.readData(PrefUtils.getInstance.userInfo);

    profileModel = ProfileModel(
      email: data['email'],
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      photo: data['photo'],
    );
    print(profileModel!.email);
  }

  apicallForAboutUs() async {
    await NetworkClient.getInstance.makeApiCall(
      "http://gvapi.trovend.com/api/General/About",
      MethodType.get,
      params: {},
      successCallback: (response, message) {
        aboutUs = response;
        update();
      },
      failureCallback: (statusCode, message) {},
    );
  }

  apicallForContactUs() async {
    await NetworkClient.getInstance.makeApiCall(
      "http://gvapi.trovend.com/api/General/Contact",
      MethodType.get,
      params: {},
      successCallback: (response, message) {
        contactUS = response;
        update();
      },
      failureCallback: (statusCode, message) {},
    );
  }

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      idTextEditingController.text = "GVC202200328";
      nameTextController.text = "dsdsd";
      descriptionTextController.text = "sdsdsd";
    }
    getUserData();
    // apicallForDashBoard();
    apicallForFaq();
    apicallForFirebaseFcmToken();
    // apicallForGetAlerts();
    apicallForAboutUs();
    apicallForContactUs();
  }
}
