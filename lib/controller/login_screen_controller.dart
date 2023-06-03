import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginScreenController extends GetxController{

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword=true;

  showPassword() {
    print("isPassword$isPassword");
    isPassword=!isPassword;
    update();
  }

}
