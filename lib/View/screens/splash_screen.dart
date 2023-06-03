import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junews/controller/splash_controller.dart';
import 'package:junews/helper/app_colors.dart';
import 'package:junews/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: ((controller) {
          return Scaffold(
              backgroundColor:  mode == ThemeMode.light?
              Colors.white:grey.withOpacity(0.2),
              body: Center(
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      "assets/images/splash_logo.png",
                    ),
                    scale: 2,
                  )),
                ),
              ));
        }));
  }
}
