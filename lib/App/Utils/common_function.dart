import 'package:flutter/material.dart';
import 'package:gasvigil/App/Utils/math_utils.dart';
import 'package:gasvigil/App/presentation/theme/app_colors.dart';
import 'package:get/get.dart';

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}

class ProgressDialog2 {
  static Future<void> showLoadingDialog(BuildContext context,
      {bool isCancellable = true}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: isCancellable,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape:const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(builder: (context) {
            return WillPopScope(
              onWillPop: () async {
                return isCancellable;                                                                                              
              },
              child:const Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.primaryColor,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class CustomDialogs {
  static CustomDialogs? _shared;

  CustomDialogs._();

  static CustomDialogs get getInstance =>
      _shared = _shared ?? CustomDialogs._();

  showCircularIndicator({
    double size = 40.0,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: getSize(50),
          width: getSize(50),
          child:const CircularProgressIndicator(
            color: ColorConstants.primaryColor,
          ),
        ),
      ],
    );
  }

  void showProgressDialog() {
    ProgressDialog2.showLoadingDialog(Get.context!, isCancellable: false);
  }

  void hideProgressDialog() {
    Get.back();
  }
}
