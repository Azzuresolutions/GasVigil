import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gasvigil/App/Utils/Routes/app_pages.dart';
import 'package:gasvigil/App/Utils/common_function.dart';
import 'package:gasvigil/App/Utils/flutter_flow_icon_button.dart';
import 'package:gasvigil/App/Utils/math_utils.dart';
import 'package:gasvigil/App/Utils/pref_utils.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:gasvigil/App/presentation/theme/app_text_theme.dart';
import 'package:gasvigil/Controller/HomeScreenController/home_screen_controller.dart';
import 'package:gasvigil/Screens/Wifi/wifi_list.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:wifi_iot/wifi_iot.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({Key? key}) : super(key: key);

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeScreenController homeScreenController =
      Get.find<HomeScreenController>();
  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.tertiaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<HomeScreenController>(
          init: HomeScreenController(),
          builder: (controller) => SingleChildScrollView(
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: const BoxDecoration(
                      color: ColorConstants.darkBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        getSize(23),
                        getSize(47),
                        getSize(23),
                        getSize(23),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Add Sensor',
                                style: whiteColor24TextStyleBold,
                              ),
                              Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: ColorConstants.background,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  buttonSize: getSize(53),
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    color: ColorConstants.textColor,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              // physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    buttonSize: getSize(180),
                                    icon: FaIcon(
                                      FontAwesomeIcons.qrcode,
                                      color: Colors.white,
                                      size: getSize(33),
                                    ),
                                    onPressed: () async {
                                      await FlutterBarcodeScanner.scanBarcode(
                                        '#C62828', // scanning line color
                                        'Cancel', // cancel button text
                                        true, // whether to show the flash icon
                                        ScanMode.QR,
                                      ).then((value) async {
                                        // await WiFiForIoTPlugin.loadWifiList();
                                        await WiFiForIoTPlugin.disconnect()
                                            .then((value) => print(value));
                                        // await WiFiForIoTPlugin.connect(
                                        //   value,
                                        //   withInternet: true,
                                        //   password: "",
                                        //   joinOnce: true,
                                        //   security: NetworkSecurity.NONE,
                                        // ).then((value) => print(value));
                                        if (value != "-1") {
                                          homeScreenController
                                              .idTextEditingController
                                              .text = value;
                                        }
                                      });
                                      homeScreenController.update();
                                    },
                                  ),
                                  Text(
                                    'Scan QR Code',
                                    style: grayLightColor14TextStyleNormal,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      getSize(20),
                                      0,
                                      0,
                                    ),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      focusNode:
                                          homeScreenController.idFocusNode,
                                      controller: homeScreenController
                                          .idTextEditingController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Id',
                                        labelStyle:
                                            grayLightColor18TextStyleMedium,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: ColorConstants.background,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: ColorConstants.background,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                          getSize(23),
                                          getSize(20),
                                          getSize(27),
                                          getSize(20),
                                        ),
                                      ),
                                      style: whiteColor20TextStyleMedium,
                                      textAlign: TextAlign.start,
                                      onFieldSubmitted: (val) {
                                        controller.nameFocusNode.requestFocus();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      getSize(20),
                                      0,
                                      0,
                                    ),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      focusNode:
                                          homeScreenController.nameFocusNode,
                                      controller: homeScreenController
                                          .nameTextController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        labelStyle:
                                            grayLightColor18TextStyleMedium,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: ColorConstants.background,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: ColorConstants.background,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                          getSize(23),
                                          getSize(20),
                                          getSize(27),
                                          getSize(20),
                                        ),
                                      ),
                                      style: whiteColor20TextStyleMedium,
                                      textAlign: TextAlign.start,
                                      onFieldSubmitted: (val) {
                                        controller.descriptionFocusNode
                                            .requestFocus();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      getSize(18),
                                      0,
                                      0,
                                    ),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: homeScreenController
                                          .descriptionTextController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Description',
                                        hintStyle:
                                            grayLightColor14TextStyleNormal,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: ColorConstants.background,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: ColorConstants.background,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                          getSize(20),
                                          getSize(40),
                                          getSize(25),
                                          0,
                                        ),
                                      ),
                                      style: whiteColor14TextStyleNormal,
                                      textAlign: TextAlign.start,
                                      maxLines: 4,
                                      focusNode:
                                          controller.descriptionFocusNode,
                                      onFieldSubmitted: (val) {
                                        FocusNode().unfocus();
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 120,
                                  )
                                ],
                              ),
                            ),
                          )

                          // const Spacer(),
                          // InkWell(
                          //   onTap: () async {
                          //     await Geolocator.isLocationServiceEnabled()
                          //         .then((value) async {
                          //       if (value) {
                          //         await WiFiForIoTPlugin.isEnabled().then((value) {
                          //           if (value) {
                          //             Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => const WifiList(),
                          //                 ));
                          //           } else {
                          //             WiFiForIoTPlugin.setEnabled(true,
                          //                 shouldOpenSettings: true);
                          //           }
                          //         });
                          //       } else {
                          //         await Geolocator.openLocationSettings();
                          //       }
                          //     });
                          //   },
                          //   child: Container(
                          //     width: 160,
                          //     height: 45,
                          //     decoration: BoxDecoration(
                          //         color: ColorConstants.tertiaryColor,
                          //         borderRadius: BorderRadius.circular(10)),
                          //     child: Center(
                          //       child: Text(
                          //         "Scan device",
                          //         style: TextStyle(
                          //             color: ColorConstants.whiteColor,
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(10),
                ),
                InkWell(
                  onTap: () async {
                    FocusScope.of(context).unfocus();

                    // dio.post(
                    //   "http://192.168.4.1/getdata.cmd?ssid=JioFiber&password=12345678",
                    // );
                    if (homeScreenController
                            .idTextEditingController.text.isEmpty ||
                        homeScreenController.nameTextController.text.isEmpty) {
                      Get.showSnackbar(GetSnackBar(
                        duration: const Duration(seconds: 2),
                        isDismissible: true,
                        borderRadius: 10,
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red.withOpacity(0.4),
                        margin: EdgeInsets.only(
                          left: getSize(20),
                          right: getSize(20),
                          top: getSize(20),
                        ),
                        titleText: Text(
                          "Error",
                          style: blackColor20TextStyleMedium,
                        ),
                        messageText: Text(
                          "Please fill all required field",
                          style: blackColor16TextStyleNormal,
                        ),
                      ));
                    } else {
                      CustomDialogs.getInstance.showProgressDialog();
                      // await WiFiForIoTPlugin.disconnect();
                      // await WiFiForIoTPlugin.forceWifiUsage(true);
                      // await WiFiForIoTPlugin.removeWifiNetwork(
                      //     controller.idTextEditingController.text);
                      // await WiFiForIoTPlugin.disconnect();
                      await WiFiForIoTPlugin.loadWifiList().then((value) async {
                        bool isAvailable = false;
                        for (int i = 0; i < value.length; i++) {
                          print(value[i].ssid);
                          if (value[i].ssid ==
                              controller.idTextEditingController.text) {
                            isAvailable = true;
                            break;
                          }
                        }

                        if (isAvailable) {
                          await WiFiForIoTPlugin.connect(
                            controller.idTextEditingController.text,
                            withInternet: false,
                            password: "",
                            joinOnce: true,
                            security: NetworkSecurity.NONE,
                          ).then((value) async {
                            if (value) {
                              await WiFiForIoTPlugin.forceWifiUsage(true);

                              await Future.delayed(const Duration(seconds: 3))
                                  .then((value) async {
                                print(PrefUtils.getInstance.readData(
                                    PrefUtils.getInstance.ssidForWifi));
                                print(PrefUtils.getInstance.readData(
                                    PrefUtils.getInstance.passwordForWifi));
                                String ssid = PrefUtils.getInstance.readData(
                                    PrefUtils.getInstance.ssidForWifi);
                                String password = PrefUtils.getInstance
                                    .readData(
                                        PrefUtils.getInstance.passwordForWifi);

                                String url =
                                    "http://192.168.4.1/getdata.cmd?ssid=" +
                                        ssid +
                                        "&password=" +
                                        password;
                                print(url);
                                try {
                                  await dio.post(url).then((value) async {
                                    print(value.data);
                                  });
                                } catch (e) {
                                  // print(e);
                                  // Get.back();
                                  // Get.snackbar("Error", "Please try agin!",
                                  //     backgroundColor:
                                  //         Colors.red.withOpacity(0.4));
                                }
                                await WiFiForIoTPlugin.removeWifiNetwork(ssid);
                                // await WiFiForIoTPlugin.disconnect();
                                print("Before==========");
                                await WiFiForIoTPlugin.connect(
                                  ssid,
                                  withInternet: false,
                                  password: password,
                                  joinOnce: true,
                                  security: NetworkSecurity.WPA,
                                ).then((value) async {
                                  print(value);
                                  if (value) {
                                    print("After=====================");
                                    await WiFiForIoTPlugin.forceWifiUsage(true);

                                    await Future.delayed(
                                            const Duration(seconds: 15))
                                        .then((value) {
                                      print("After Delay=====================");

                                      homeScreenController
                                          .apicallForCheckNewDevice();
                                    });
                                  } else {
                                    Get.back();
                                    Get.snackbar("Error", "Please try again",
                                        backgroundColor:
                                            Colors.red.withOpacity(0.4));
                                  }
                                });
                                print("After-----------------------");

                                // print(value);
                              });
                            } else {
                              Get.back();
                              Get.snackbar("Error", "Please try again",
                                  backgroundColor: Colors.red.withOpacity(0.4));
                            }
                          });
                        } else {
                          Get.back();
                          Get.snackbar("Error", "Device not found",
                              backgroundColor: Colors.red.withOpacity(0.4));
                        }
                      });
                    }
                  },
                  child: Text(
                    "Add Device",
                    style: whiteColor32TextStyleBold,
                  ),
                ),
                SizedBox(
                  height: getSize(20),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.webViewScreen);
                  },
                  child: Text(
                    'How To Add New Device?',
                    style: grayLightColor18TextStyleMedium.copyWith(
                      // fontFamily: 'Lexend Deca',
                      color: const Color(0x43000000),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
