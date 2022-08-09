import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gasvigil/App/Utils/Routes/app_pages.dart';
import 'package:gasvigil/App/Utils/math_utils.dart';
import 'package:gasvigil/App/Utils/network_client.dart';
import 'package:gasvigil/App/Utils/pref_utils.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:gasvigil/App/presentation/theme/app_text_theme.dart';
import 'package:gasvigil/Controller/HomeScreenController/home_screen_controller.dart';
import 'package:gasvigil/Screens/MyDevices/my_devices_screen.dart';
import 'package:gasvigil/Screens/Wifi/wifi_list.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_iot/wifi_iot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController homeScreenController =
      Get.find<HomeScreenController>();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    homeScreenController.apicallForDashBoard();
    homeScreenController.apicallForGetAlerts();
    FirebaseMessaging.onMessage.listen((event) {
      homeScreenController.apicallForDashBoard();
      homeScreenController.apicallForGetAlerts();
      homeScreenController.apicallForGetDevice();
    });
    FirebaseMessaging.instance.getToken().then((value) {
      print(value);
    });
    if (kDebugMode) {
      passwordController.text = "12345678";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homeScreenController.nodataFound = false;
    WiFiForIoTPlugin.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "abcd",
          onPressed: () async {
            // PrefUtils.getInstance.writeData(
            //     PrefUtils.getInstance.ssidForWifi, "jioFiber-AhG8a_5G");
            // PrefUtils.getInstance
            //     .writeData(PrefUtils.getInstance.passwordForWifi, "12345678");
            // Get.toNamed(Routes.addDeviceScreen);
            await Geolocator.isLocationServiceEnabled().then((value) async {
              if (value) {
                await WiFiForIoTPlugin.isConnected().then((value) async {
                  if (value) {
                    await WiFiForIoTPlugin.loadWifiList();
                    await WiFiForIoTPlugin.getSSID().then((value1) {
                      print(value1);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Enter password"),
                            content: TextField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                  hintText: "Please Enter password"),
                            ),
                            actions: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                onPressed: () async {
                                  Get.back();
                                  FocusScope.of(context).unfocus();
                                  if (passwordController.text.isNotEmpty) {
                                    PrefUtils.getInstance.writeData(
                                        PrefUtils.getInstance.passwordForWifi,
                                        passwordController.text);
                                    PrefUtils.getInstance.writeData(
                                        PrefUtils.getInstance.ssidForWifi,
                                        value1);
                                    passwordController.clear();

                                    Get.toNamed(Routes.addDeviceScreen);
                                  } else {
                                    Get.snackbar("Error", "Enter password",
                                        backgroundColor:
                                            Colors.red.withOpacity(0.4));
                                  }
                                },
                                child: const Text("Ok"),
                              )
                            ],
                          );
                        },
                      );
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return WillPopScope(
                          onWillPop: () async {
                            return false;
                          },
                          child: AlertDialog(
                            title: const Text("Alert"),
                            content:
                                const Text("Connect wifi first to add device"),
                            actions: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                onPressed: () async {
                                  await WiFiForIoTPlugin.isEnabled()
                                      .then((value) {
                                    if (value) {
                                      Get.back();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const WifiList(),
                                          ));
                                    } else {
                                      WiFiForIoTPlugin.setEnabled(true,
                                          shouldOpenSettings: true);
                                    }
                                  });
                                },
                                child: const Text("Connect"),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                });
              } else {
                await Geolocator.openLocationSettings();
              }
            });
          },
          backgroundColor: ColorConstants.tertiaryColor,
          elevation: 8,
          child: Icon(
            Icons.add_rounded,
            color: ColorConstants.textColor,
            size: getSize(36),
          ),
        ),
        appBar: AppBar(
          backgroundColor: ColorConstants.background,
          automaticallyImplyLeading: false,
          title: Text(
            'My Alerts',
            style: whiteColor24TextStyleBold,
          ),
          centerTitle: false,
          elevation: 0,
        ),
        backgroundColor: ColorConstants.background,
        body: GetBuilder<HomeScreenController>(
          init: HomeScreenController(),
          builder: (controller) => (homeScreenController.isShowProgress)
              ? Center(
                  child: SizedBox(
                    height: getSize(50),
                    width: getSize(50),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ),
                )
              : SafeArea(
                  child: Column(
                    children: [
                      // Container(
                      //   width: double.infinity,
                      //   margin: EdgeInsets.only(
                      //     left: getSize(20),
                      //     right: getSize(20),
                      //   ),
                      //   decoration: BoxDecoration(
                      //     boxShadow: const [
                      //       BoxShadow(
                      //         blurRadius: 6,
                      //         color: Color(0x4B1A1F24),
                      //         offset: Offset(0, 2),
                      //       )
                      //     ],
                      //     gradient: const LinearGradient(
                      //       colors: [Color(0xFF00968A), Color(0xFFF2A384)],
                      //       stops: [0, 1],
                      //       begin: AlignmentDirectional(0.94, -1),
                      //       end: AlignmentDirectional(-0.94, 1),
                      //     ),
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.max,
                      //     children: [
                      //       Padding(
                      //         padding:
                      //             EdgeInsetsDirectional.fromSTEB(20, 24, 20, 0),
                      //         child: Row(
                      //           mainAxisSize: MainAxisSize.max,
                      //           children: [
                      //             Text('Total Alerts',
                      //                 style: whiteColor14TextStyleNormal),
                      //           ],
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding:
                      //             EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
                      //         child: Row(
                      //           mainAxisSize: MainAxisSize.max,
                      //           children: [
                      //             Text('0', style: whiteColor32TextStyleBold),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: getSize(20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getSize(20),
                          right: getSize(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                // width: getSize(150),
                                height: getSize(120),
                                padding: EdgeInsets.all(getSize(10)),
                                decoration: BoxDecoration(
                                  color: ColorConstants.darkBackground,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Alerts",
                                      style: whiteColor20TextStyleMedium,
                                    ),
                                    const Spacer(),
                                    Center(
                                      child: Text(
                                        homeScreenController
                                                .dashBoardModel?.alertsCount
                                                .toString() ??
                                            "0",
                                        style: whiteColor20TextStyleMedium,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getSize(15),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MydevicesScreen()),
                                  );
                                },
                                child: Container(
                                  // width: getSize(150),
                                  padding: EdgeInsets.all(getSize(10)),

                                  height: getSize(120),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.darkBackground,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Devices",
                                        style: whiteColor20TextStyleMedium,
                                      ),
                                      const Spacer(),
                                      Center(
                                        child: Text(
                                          homeScreenController
                                                  .dashBoardModel?.deviceCount
                                                  .toString() ??
                                              "0",
                                          style: whiteColor20TextStyleMedium,
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getSize(20),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: ColorConstants.darkBackground,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 12, 20, 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Alerts',
                                    style: grayLightColor14TextStyleNormal,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GetBuilder<HomeScreenController>(
                          init: HomeScreenController(),
                          builder: (controller) => SafeArea(
                              child: (!homeScreenController.nodataFound)
                                  ? (homeScreenController.allAlerts.isEmpty)
                                      ? Center(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              top: getSize(50),
                                            ),
                                            height: getSize(50),
                                            width: getSize(50),
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color:
                                                    ColorConstants.primaryColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          // height: getSize(540),
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            padding: EdgeInsets.only(
                                              top: getSize(
                                                20,
                                              ),
                                            ),
                                            itemBuilder: (context, index) =>
                                                Container(
                                              padding: const EdgeInsets.all(10),
                                              margin: EdgeInsets.only(
                                                  left: getSize(20),
                                                  right: getSize(20)),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorConstants
                                                    .darkBackground,
                                                border: Border.all(
                                                    color: ColorConstants
                                                        .whiteColor
                                                        .withOpacity(
                                                      0.5,
                                                    ),
                                                    width: 1),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Id : ",
                                                        style:
                                                            whiteColor20TextStyleMedium,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          homeScreenController
                                                                  .allAlerts[
                                                                      index]
                                                                  .device
                                                                  ?.deviceId
                                                                  ?.toString() ??
                                                              "",
                                                          style:
                                                              whiteColor16TextStyleNormal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Notes : ",
                                                        style:
                                                            whiteColor20TextStyleMedium,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            homeScreenController
                                                                    .allAlerts[
                                                                        index]
                                                                    .notes ??
                                                                "",
                                                            style:
                                                                whiteColor16TextStyleNormal),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              height: getSize(20),
                                            ),
                                            itemCount: homeScreenController
                                                .allAlerts.length,
                                          ),
                                        )
                                  : Padding(
                                      padding: EdgeInsets.only(
                                        top: getSize(50),
                                      ),
                                      child: Text(
                                        "No data found",
                                        style: whiteColor20TextStyleMedium,
                                      ),
                                    )),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
