import 'package:get/get.dart';

import '../view/screens/home_screen.dart';
import '../view/screens/login_screen.dart';

class SplashController extends GetxController {
  bool isLogin = false;



  @override
  void onInit() async {
    isLogin = false;
    await Future.delayed(const Duration(seconds: 4)).then((value) async {
      if (isLogin) {
        return Get.offAll(() => const HomeScreen());

      } else {
        return Get.offAll(() => const LoginScreen());
      }
    });
    super.onInit();
  }
}
