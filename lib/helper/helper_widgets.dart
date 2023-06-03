import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperWidgets {
  static loading() {
    Get.closeCurrentSnackbar();
    Get.closeAllSnackbars();
    if (Platform.isIOS) {
      Get.dialog(
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoActivityIndicator(),
            ],
          ),
          barrierColor: Get.theme.scaffoldBackgroundColor.withOpacity(0.6),
          barrierDismissible: true);
    } else {
      Get.dialog(
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
          barrierColor: Get.theme.scaffoldBackgroundColor.withOpacity(0.6),
          barrierDismissible: false);
    }
  }
}
