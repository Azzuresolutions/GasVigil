import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasvigil/App/Utils/math_utils.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:gasvigil/App/presentation/theme/app_text_theme.dart';
import 'package:gasvigil/Controller/HomeScreenController/home_screen_controller.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
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
          'About Us',
          style: whiteColor24TextStyleBold,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: getSize(20), right: getSize(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "About App",
              style: whiteColor20TextStyleMedium.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              homeScreenController.aboutUs['aboutApp'] ?? "",
              style: whiteColor16TextStyleNormal,
            ),
            Divider(
              color: ColorConstants.whiteColor.withOpacity(0.5),
            ),
            Text(
              "Version",
              style: whiteColor20TextStyleMedium.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              homeScreenController.aboutUs['version'] ?? "",
              style: whiteColor16TextStyleNormal,
            ),
            Divider(
              color: ColorConstants.whiteColor.withOpacity(0.5),
            )
          ],
        ),
      ),
    );
  }
}
