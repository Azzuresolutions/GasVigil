import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasvigil/App/Utils/Routes/app_pages.dart';
import 'package:gasvigil/App/Utils/network_client.dart';
import 'package:gasvigil/App/Utils/pref_utils.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:gasvigil/App/presentation/theme/app_text_theme.dart';
import 'package:gasvigil/Controller/HomeScreenController/home_screen_controller.dart';
import 'package:gasvigil/Screens/AddDevice/add_device_screen.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiList extends StatefulWidget {
  const WifiList({Key? key}) : super(key: key);

  @override
  State<WifiList> createState() => _WifiListState();
}

class _WifiListState extends State<WifiList> {
  final HomeScreenController homeScreenController =
      Get.find<HomeScreenController>();
  Timer? timer;
  refreshUi() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) setState(() {});
    });
  }

  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    // if (mounted) timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // refreshUi();
    });
    return Scaffold(
      backgroundColor: ColorConstants.background,
      appBar: AppBar(
        backgroundColor: ColorConstants.background,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          'Wifi',
          style: whiteColor24TextStyleBold,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: FutureBuilder<List<WifiNetwork>>(
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return ListView.separated(
                    padding: const EdgeInsets.all(0),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      // if (homeScreenController.idTextEditingController.text ==
                      //     snapshot.data![index].ssid) {
                      //   automaticallyConnectWifi(
                      //       ssid: snapshot.data![index].ssid);
                      // }
                      return InkWell(
                        onTap: () async {
                          WiFiForIoTPlugin.forceWifiUsage(true);

                          if (snapshot.data![index].capabilities == "[ESS]") {
                            await WiFiForIoTPlugin.connect(
                              snapshot.data![index].ssid.toString(),
                              withInternet: false,
                              // password: "",
                              joinOnce: false,
                              security: NetworkSecurity.NONE,
                            ).then((value) async {
                              await WiFiForIoTPlugin.isConnected().then(
                                  (value) => print(
                                      "is connected " + value.toString()));

                              print(value);
                            });
                          } else {
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
                                        if (passwordController
                                            .text.isNotEmpty) {
                                          await WiFiForIoTPlugin.disconnect();
                                          await WiFiForIoTPlugin.connect(
                                            snapshot.data![index].ssid
                                                .toString(),
                                            withInternet: false,
                                            password: passwordController.text,
                                            joinOnce: true,
                                            security: NetworkSecurity.WPA,
                                          ).then((value) async {
                                            print(value);
                                            if (value) {
                                              PrefUtils.getInstance.writeData(
                                                PrefUtils
                                                    .getInstance.ssidForWifi,
                                                snapshot.data![index].ssid
                                                    .toString(),
                                              );
                                              PrefUtils.getInstance.writeData(
                                                  PrefUtils.getInstance
                                                      .passwordForWifi,
                                                  passwordController.text);
                                              passwordController.clear();
                                              Get.back();
                                              FocusScope.of(context).unfocus();
                                              await WiFiForIoTPlugin
                                                  .forceWifiUsage(false);
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddDeviceScreen(),
                                                  ),
                                                  ModalRoute.withName(
                                                      Routes.dashBoardScreen));
                                            } else {
                                              Get.snackbar(
                                                  "Error", "Please try again",
                                                  backgroundColor: Colors.red
                                                      .withOpacity(0.4));
                                            }
                                          });
                                        } else {
                                          Get.snackbar(
                                              "Error", "Enter password",
                                              backgroundColor:
                                                  Colors.red.withOpacity(0.4));
                                        }

                                        // Dio dio = Dio();
                                        // try {
                                        //   dio
                                        //       .post(
                                        //           "http://192.168.4.1/getdata.cmd?ssid=${snapshot.data![index].ssid}&password=${passwordController.text}",
                                        //           options: Options(
                                        //               receiveTimeout: 2500))
                                        //       .then((value) {
                                        //     print(value.data);
                                        //     if (value.data == "1") {
                                        //       passwordController.clear();

                                        //       Get.snackbar("Success",
                                        //           "Internet connected successfully",
                                        //           backgroundColor:
                                        //               ColorConstants
                                        //                   .tertiaryColor
                                        //                   .withOpacity(0.5));
                                        //     } else {
                                        //       Get.snackbar(
                                        //           "Error", "Please try agin!",
                                        //           backgroundColor: Colors.red
                                        //               .withOpacity(0.4));
                                        //     }
                                        //   });
                                        // } catch (e) {
                                        //   Get.snackbar(
                                        //       "Error", "Please try agin!",
                                        //       backgroundColor: Colors.red
                                        //           .withOpacity(0.4));
                                        // }
                                      },
                                      child: const Text("Connect"),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: ColorConstants.tertiaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(snapshot.data![index].ssid.toString()),
                              const Icon(Icons.arrow_forward_ios_rounded)
                            ],
                          ),
                        ),
                      );
                    });
              }
              return Container();
            },
            future: WiFiForIoTPlugin.loadWifiList(),
          ),
        ),
      ),
    );
  }

  automaticallyConnectWifi({String? ssid}) async {
    await WiFiForIoTPlugin.isConnected().then((value) async {
      if (!value) {
        await WiFiForIoTPlugin.connect(
          ssid!,
          withInternet: true,
          // password: "",
          joinOnce: false,
          security: NetworkSecurity.NONE,
        );
      }
    });
  }
}
