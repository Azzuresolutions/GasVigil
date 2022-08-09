import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasvigil/App/Utils/Routes/app_pages.dart';
import 'package:gasvigil/App/Utils/flutter_flow_icon_button.dart';
import 'package:gasvigil/App/Utils/math_utils.dart';
import 'package:gasvigil/App/Utils/pref_utils.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:gasvigil/App/presentation/theme/app_text_theme.dart';
import 'package:gasvigil/Controller/HomeScreenController/home_screen_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
      timer.cancel();
    });
  }

  final HomeScreenController homeScreenController =
      Get.find<HomeScreenController>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    setState(() {});
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: getSize(250),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Color(0x4B1A1F24),
                  offset: Offset(0, 2),
                )
              ],
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00968A),
                  Color(0xFFF2A384),
                ],
                stops: [0, 1],
                begin: AlignmentDirectional(0.94, -1),
                end: AlignmentDirectional(-0.94, 1),
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: getSize(20), right: getSize(20), top: getSize(70)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: ColorConstants.primaryColor,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            getSize(2),
                            getSize(2),
                            getSize(2),
                            getSize(2),
                          ),
                          child: Container(
                            width: getSize(62),
                            height: getSize(62),
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              homeScreenController.profileModel?.photo ?? "",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: getSize(45),
                        height: getSize(45),
                        decoration: BoxDecoration(
                          color: const Color(0x40000000),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(
                                        "Logout",
                                        style: blackColor20TextStyleMedium,
                                      ),
                                      content: Text(
                                        "Are you sure you want to logout?",
                                        style: blackColor16TextStyleNormal,
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              ColorConstants.primaryColor,
                                            ),
                                            elevation:
                                                MaterialStateProperty.all(16),
                                          ),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            "No",
                                            style: blackColor14TextStyleNormal,
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    ColorConstants
                                                        .primaryColor),
                                            elevation:
                                                MaterialStateProperty.all(16),
                                          ),
                                          onPressed: () {
                                            final FirebaseAuth auth =
                                                FirebaseAuth.instance;
                                            auth.signOut();
                                            PrefUtils.getInstance
                                                .clearLocalStorage();
                                            Get.offAllNamed(Routes.logInScreen);
                                          },
                                          child: Text(
                                            "Yes",
                                            style: blackColor14TextStyleNormal,
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                          child: Icon(
                            Icons.login_outlined,
                            color: ColorConstants.textColor,
                            size: getSize(24),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        homeScreenController.profileModel?.name ?? "",
                        style: whiteColor20TextStyleMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Text(
                      //   "Name",
                      //   style: whiteColor14TextStyleNormal.copyWith(
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: getSize(10),
                      // ),
                      Text(
                        homeScreenController.profileModel?.email ?? "",
                        style: whiteColor14TextStyleNormal.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getSize(20),
              top: getSize(40),
              right: getSize(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    Get.toNamed(Routes.notificationSettingScreen);
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: getSize(62),
                      decoration: BoxDecoration(
                        color: ColorConstants.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF090F13),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: getSize(20),
                          right: getSize(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Notification Settings',
                                style: whiteColor14TextStyleNormal),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30,
                              buttonSize: getSize(46),
                              icon: Icon(
                                Icons.chevron_right_rounded,
                                color: const Color(0xFF95A1AC),
                                size: getSize(20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(20),
                ),
                InkWell(
                  onTap: () async {
                    Get.toNamed(Routes.aboutUsScreen);
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: getSize(62),
                      decoration: BoxDecoration(
                        color: ColorConstants.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF090F13),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: getSize(20),
                          right: getSize(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('About us',
                                style: whiteColor14TextStyleNormal),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30,
                              buttonSize: getSize(46),
                              icon: Icon(
                                Icons.chevron_right_rounded,
                                color: const Color(0xFF95A1AC),
                                size: getSize(20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(20),
                ),
                InkWell(
                  onTap: () async {
                    Get.toNamed(Routes.contactUsScreen);
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: getSize(62),
                      decoration: BoxDecoration(
                        color: ColorConstants.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF090F13),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: getSize(20),
                          right: getSize(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Contact us',
                                style: whiteColor14TextStyleNormal),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30,
                              buttonSize: getSize(46),
                              icon: Icon(
                                Icons.chevron_right_rounded,
                                color: const Color(0xFF95A1AC),
                                size: getSize(20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(20),
                ),
                InkWell(
                  onTap: () async {
                    Get.toNamed(Routes.faqScreen);
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: getSize(62),
                      decoration: BoxDecoration(
                        color: ColorConstants.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF090F13),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: getSize(20),
                          right: getSize(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('FAQ', style: whiteColor14TextStyleNormal),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30,
                              buttonSize: getSize(46),
                              icon: Icon(
                                Icons.chevron_right_rounded,
                                color: const Color(0xFF95A1AC),
                                size: getSize(20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
