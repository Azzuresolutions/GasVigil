import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gasvigil/App/Utils/math_utils.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:gasvigil/App/presentation/theme/app_text_theme.dart';
import 'package:gasvigil/Controller/HomeScreenController/home_screen_controller.dart';
import 'package:get/get.dart';

class MydevicesScreen extends StatefulWidget {
  const MydevicesScreen({Key? key}) : super(key: key);

  @override
  State<MydevicesScreen> createState() => _MydevicesScreenState();
}

class _MydevicesScreenState extends State<MydevicesScreen> {
  final HomeScreenController homeScreenController =
      Get.find<HomeScreenController>();
  @override
  void initState() {
    super.initState();
    homeScreenController.apicallForGetDevice();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homeScreenController.nodataFound = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      appBar: AppBar(
        backgroundColor: ColorConstants.background,
        automaticallyImplyLeading: false,
        title: Text(
          'My Devices',
          style: whiteColor24TextStyleBold,
        ),
        centerTitle: false,
        elevation: 0,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {},
      //   backgroundColor: ColorConstants.tertiaryColor,
      //   elevation: 8,
      //   child: Icon(
      //     Icons.post_add_rounded,
      //     color: ColorConstants.textColor,
      //     size: getSize(32),
      //   ),
      // ),
      body: GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) => SafeArea(
          child: (!homeScreenController.nodataFound)
              ? (homeScreenController.alldevices.isEmpty)
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
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: getSize(
                          20,
                        ),
                      ),
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.only(
                            left: getSize(20), right: getSize(20)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: (homeScreenController
                                      .alldevices[index].alertStatus ==
                                  0)
                              ? Colors.grey
                              : (homeScreenController
                                          .alldevices[index].alertStatus ==
                                      1)
                                  ? Colors.blue
                                  : (homeScreenController
                                              .alldevices[index].alertStatus ==
                                          2)
                                      ? Colors.yellow
                                      : (homeScreenController.alldevices[index]
                                                  .alertStatus ==
                                              3)
                                          ? Colors.red
                                          : Colors.green,
                          border: Border.all(
                              color: ColorConstants.whiteColor.withOpacity(
                                0.5,
                              ),
                              width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Id : ",
                                  style: whiteColor20TextStyleMedium,
                                ),
                                Expanded(
                                  child: Text(
                                    homeScreenController
                                            .alldevices[index].deviceId ??
                                        "",
                                    style: whiteColor16TextStyleNormal,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Name : ",
                                  style: whiteColor20TextStyleMedium,
                                ),
                                Expanded(
                                  child: Text(
                                    homeScreenController
                                            .alldevices[index].name ??
                                        "",
                                    style: whiteColor16TextStyleNormal,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Description : ",
                                  style: whiteColor20TextStyleMedium,
                                ),
                                Expanded(
                                  child: Text(
                                      homeScreenController
                                              .alldevices[index].description ??
                                          "",
                                      style: whiteColor16TextStyleNormal),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: getSize(20),
                      ),
                      itemCount: homeScreenController.alldevices.length,
                    )
              : Center(
                  child: Text(
                    "No data found",
                    style: whiteColor20TextStyleMedium,
                  ),
                ),
        ),
      ),
    );
  }
}
