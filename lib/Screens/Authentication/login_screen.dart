import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasvigil/App/Utils/math_utils.dart';
import 'package:gasvigil/App/presentation/constants/image_constants.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:gasvigil/App/presentation/theme/app_text_theme.dart';
import 'package:gasvigil/Controller/AuthenticationController/authentication_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final authenticationController =
      Get.put<AuthenticationController>(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(loginScreenImage), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getSize(80),
            ),
            Container(
              margin: EdgeInsets.only(
                left: getSize(30),
                right: getSize(30),
              ),
              width: double.infinity,
              height: getSize(400),
              child: Image.asset(
                gasvigilLogin,
                fit: BoxFit.fill,
              ),
            ),
            InkWell(
              onTap: () async {
                await authenticationController.signinWithGoogle();
              },
              child: Container(
                width: double.infinity,
                height: getSize(50),
                margin: EdgeInsets.only(
                  left: getSize(80),
                  right: getSize(80),
                ),
                padding: EdgeInsets.only(
                  left: getSize(10),
                  right: getSize(10),
                ),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: ColorConstants.whiteColor),
                child: Row(
                  children: [
                    Image.network(
                      'https://i0.wp.com/nanophorm.com/wp-content/uploads/2018/04/google-logo-icon-PNG-Transparent-Background.png?w=1000&ssl=1',
                      fit: BoxFit.contain,
                      height: getSize(35),
                      width: getSize(35),
                    ),
                    SizedBox(
                      width: getSize(0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign in with Google",
                            style: blackColor24TextStyleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
