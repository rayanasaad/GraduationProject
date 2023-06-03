import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:junews/helper/app_colors.dart';
import 'package:junews/main.dart';

class CustomButton extends StatelessWidget {
   CustomButton({Key? key, this.onPressed, this.text}) : super(key: key);
  final Function ()? onPressed;
  final String ? text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      disabledColor: mode ==ThemeMode.light ?mainGreenColor:grey,
      color: mode ==ThemeMode.light ?mainGreenColor:grey,
      child: Container(

          height: Get.height*0.06,width: Get.width*0.4,

        child: Center(
          child: Text(
            text!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
