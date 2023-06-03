import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:junews/helper/app_colors.dart';
import 'package:junews/main.dart';

class CustomTextFiled extends StatelessWidget {
   CustomTextFiled({
     Key? key,
     required this.controller,
     this.type,
     required this.validation,
     this.hint,
     this.label,
     this.prefix,
     required this.isPassword,
      this.suffixPressed,
   this.suffix
   }) : super(key: key);
  final TextEditingController ? controller;
    TextInputType ? type;
  final FormFieldValidator<String>? validation;
   String ? hint;
   String ? label;
   IconData ? prefix;
   bool isPassword = false;
   Callback?suffixPressed;
      IconData ? suffix;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      autocorrect: false,
      cursorColor: mode ==ThemeMode.light ?mainGreenColor:grey,
      decoration: InputDecoration(
        labelStyle:  TextStyle(
            fontSize: 18,
          color:mode ==ThemeMode.light ?mainGreenColor:grey
        ),
        enabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(
              color:mode ==ThemeMode.light ?mainGreenColor:grey

          ),
        ),
        focusedBorder:  UnderlineInputBorder(
          borderSide: BorderSide(
            color:mode ==ThemeMode.light ?mainGreenColor:grey,
           ),),
        hintText: hint,
        hintStyle:  TextStyle(
          color:mode ==ThemeMode.light ?mainGreenColor:grey
        ),
        labelText: label,

        prefixIcon:Icon(
          prefix,
          color: grey,
        ),
        fillColor:mainGreenColor,


        suffixIcon:suffix != null ?
        InkWell(
          onTap: suffixPressed,
          child: Icon(
            suffix,
            color:grey,
          ),
        ):null,

      ),
      keyboardType: type,
      validator:validation,

    );
  }
}
