import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasvigil/App/Utils/Routes/app_pages.dart';
import 'package:gasvigil/App/Utils/math_utils.dart';
import 'package:gasvigil/App/Utils/pref_utils.dart';
import 'package:gasvigil/App/presentation/constants/image_constants.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:gasvigil/App/presentation/theme/app_text_theme.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goNextFromSplash();
  }

  Future<void> goNextFromSplash() async {
    PrefUtils.getInstance.isUserLogin();
    Future.delayed(const Duration(milliseconds: 2500), () async {
      await FirebaseMessaging.instance.getToken().then((value) => print(value));
      if (await PrefUtils.getInstance.isUserLogin()) {
        // PrefUtils.getInstance.initializeUser();
        Get.offAllNamed(Routes.dashBoardScreen);
      } else {
        Get.offNamed(Routes.logInScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: getSize(300),
            width: double.infinity,
            child: Center(child: Image.asset(splashScreenImage)),
          ),
          Text(
            "GASVIGIL",
            style: whiteColor32TextStyleBold.copyWith(
                letterSpacing: 1.8,
                fontSize: getSize(45),
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
