import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasvigil/App/Utils/math_utils.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:gasvigil/App/presentation/theme/app_text_theme.dart';
import 'package:gasvigil/Controller/HomeScreenController/home_screen_controller.dart';
import 'package:get/get.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final HomeScreenController homeScreenController =
      Get.find<HomeScreenController>();

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
          'FAQ',
          style: whiteColor24TextStyleBold,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) => Padding(
            padding: EdgeInsets.only(
              left: getSize(20),
              right: getSize(20),
            ),
            child: (homeScreenController.faQ.isEmpty)
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
                      top: getSize(20),
                    ),
                    itemBuilder: (context, index) {
                      return AnimatedCrossFade(
                        crossFadeState: homeScreenController.isShowMore[index]
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 200),
                        firstChild: Container(
                          padding: EdgeInsets.all(
                            getSize(10),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorConstants.whiteColor.withOpacity(
                              0.1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  for (int i = 0;
                                      i <
                                          homeScreenController
                                              .isShowMore.length;
                                      i++) {
                                    homeScreenController.isShowMore[i] = false;
                                  }
                                  homeScreenController.isShowMore[index] = true;
                                  homeScreenController.update();
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   (index + 1).toString() + ".",
                                    //   style: whiteColor20TextStyleMedium,
                                    // ),
                                    // SizedBox(
                                    //   width: getSize(10),
                                    // ),
                                    Expanded(
                                      child: Text(
                                        homeScreenController.faQ[index].question
                                                ?.toString() ??
                                            "",
                                        style: whiteColor20TextStyleMedium,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: ColorConstants.whiteColor,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        secondChild: Container(
                          padding: EdgeInsets.all(
                            getSize(10),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorConstants.whiteColor.withOpacity(
                              0.1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  homeScreenController.isShowMore[index] =
                                      false;
                                  homeScreenController.update();
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   (index + 1).toString() + ".",
                                    //   style: whiteColor20TextStyleMedium,
                                    // ),
                                    // SizedBox(
                                    //   width: getSize(10),
                                    // ),
                                    Expanded(
                                      child: Text(
                                        homeScreenController.faQ[index].question
                                                ?.toString() ??
                                            "",
                                        style: whiteColor20TextStyleMedium,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_up,
                                      color: ColorConstants.whiteColor,
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                indent: 0,
                                endIndent: 0,
                                color:
                                    ColorConstants.whiteColor.withOpacity(0.8),
                              ),
                              Text(
                                homeScreenController.faQ[index].answer ?? "",
                                style: whiteColor16TextStyleNormal,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: getSize(30),
                    ),
                    itemCount: homeScreenController.faQ.length,
                  )),
      ),
    );
  }
}
