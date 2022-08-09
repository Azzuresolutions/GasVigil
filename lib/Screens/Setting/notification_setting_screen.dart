import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasvigil/App/Utils/math_utils.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:gasvigil/App/presentation/theme/app_text_theme.dart';
import 'package:get/get.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool setting = true;
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
          child:const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          'Notification Setting',
          style: whiteColor24TextStyleBold,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: MathUtilities.safeAreaTopHeight(context) + getSize(20),
            left: getSize(20),
            right: getSize(20)),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Turn off Notification",
                  style: whiteColor16TextStyleNormal.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
           const     Spacer(),
                Switch(
                  activeColor: ColorConstants.primaryColor,
                  value: setting,
                  onChanged: (val) {
                    setting = val;
                    setState(() {});
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
