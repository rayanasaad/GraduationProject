import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junews/View/widget/custom_button.dart';
import 'package:junews/View/widget/custom_text_filed.dart';
import 'package:junews/controller/home_screen_controller.dart';

import 'package:junews/controller/login_screen_controller.dart';
import 'package:junews/helper/app_colors.dart';
import 'package:junews/helper/helper_widgets.dart';
import 'package:junews/model/user_model.dart';
import '../../main.dart';
import '../widget/ju_news_widget.dart';
import 'home_screen.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder <LoginScreenController>(
      init: LoginScreenController(),
        builder:(controller){
      return Scaffold(
        body: SafeArea(
          child: SizedBox(
           width: Get.width,
              height: Get.height,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration:  BoxDecoration(
                          color: mode ==ThemeMode.light ? mainGreenColor.withOpacity(0.2):secondDarkColor
                        ),
                        width: Get.width,
                        height:Get.height*0.4,
                        child: Padding(
                          padding:  EdgeInsets.only(top: Get.height*0.03),
                          child: Column(
                            children: [
                              Image(
                                image: const AssetImage("assets/images/JU.png"),
                                height:  Get.height*0.25,

                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: Get.height*0.3,
                        left: Get.width*0.1,
                        child: Column(
                          children: [
                            Container(
                                width: Get.width*0.8,
                                height: Get.height*0.55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.2),
                                      blurRadius: 1.0,
                                      offset:const Offset(0,1),
                                    ),
                                  ],
                                  color:mode ==ThemeMode.dark ? grey2 : white,
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.all(Get.width*0.05),
                                  child: Column(
                                    children: [
                                      Text(
                                        "login".tr,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        color: grey2,
                                      ),
                                      ),
                                      SizedBox(height: Get.height*0.05,),
                                      Form(
                                        key:controller.formKey,
                                        child: Column(
                                          children: [
                                            CustomTextFiled(
                                                controller: controller.email,
                                                type: TextInputType.emailAddress,
                                                prefix: Icons.email,
                                                label: "emailAddress".tr,
                                                validation: (value){
                                                  if(value!.isEmpty)
                                                  {
                                                    return "emailMustNotBeEmpty".tr;
                                                  }
                                                  return null;
                                                },
                                              isPassword: false,
                                            ),
                                            SizedBox(height: Get.height*0.04,),
                                            CustomTextFiled(
                                                controller: controller.pass,
                                                label: "password".tr,
                                                prefix: Icons.lock,
                                                suffix: controller.isPassword ==true?Icons.visibility_off: Icons.visibility,
                                                type: TextInputType.text,
                                                isPassword:controller.isPassword,
                                                suffixPressed:() {
                                                      controller.showPassword();
                                                    },
                                                validation: (value){
                                                  if(value!.isEmpty)
                                                  {
                                                    return "passwordMustNotBeEmpty".tr;
                                                  }
                                                  return null;
                                                }
                                            ),
                                            SizedBox(height: Get.height*0.02,),
                                            GetBuilder<HomeScreenController>(
                                              init: HomeScreenController(),
                                              builder: (homeController) {
                                                return CustomButton(
                                                    text: "login".tr,
                                                    onPressed: () async {
                                                     if(controller.formKey.currentState!.validate()) {
                                                       HelperWidgets.loading();
                                                       try {
                                                        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                                            email: controller.email.text,
                                                            password: controller.pass.text,
                                                        );

                                                        homeController.user =UserModel(
                                                          email: userCredential.user!.email??controller.email.text,
                                                            nameEN: "",
                                                            nameAR: "",
                                                            collegeEN: "",
                                                            collegeAR: "",
                                                            pic: "",
                                                            uid: userCredential.user!.uid,
                                                        );
                                                        print("email = ${  homeController.user.email}");
                                                        print("id = ${  homeController.user.uid}");

                                                          homeController.isLoading = true;
                                                          homeController.update();
                                                          Get.back();

                                                          Get.offAll((const HomeScreen()));

                                                      } on FirebaseAuthException catch (e) {
                                                        if (e.code == 'user-not-found') {
                                                          Get.back();
                                                          AwesomeDialog(
                                                              // dialogBackgroundColor:mode ==ThemeMode.light ?Colors.white:grey,
                                                            padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                            context: context,
                                                            dialogType:
                                                            DialogType
                                                                .warning,
                                                            animType: AnimType
                                                                .rightSlide,
                                                            title:
                                                            "cannotFindAccount".tr,
                                                            titleTextStyle: const TextStyle(
                                                                color:  mainRedColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                            desc:
                                                            " ${"cannotFindAnAccountWith".tr} ${controller.email.text} ${"pleaseEnterCorrectEmail".tr}",

                                                            btnOkColor:
                                                            mainRedColor,
                                                            btnOkText:
                                                            'ok'.tr,
                                                            btnOkOnPress: () {
                                                              Get.back();
                                                            },
                                                          ).show();
                                                        } else if (e.code == 'wrong-password') {
                                                          AwesomeDialog(
                                                            // dialogBackgroundColor:mode ==ThemeMode.light ?Colors.white:grey,
                                                            padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                            context: context,
                                                            dialogType:
                                                            DialogType
                                                                .warning,
                                                            animType: AnimType
                                                                .rightSlide,
                                                            title:
                                                            "incorrectPassword".tr,
                                                            titleTextStyle: const TextStyle(
                                                                color: mainRedColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                            desc:
                                                            "thePasswordEnteredIsIncorrect".tr,
                                                            btnOkColor:
                                                            mainRedColor,
                                                            btnOkText:
                                                            'ok'.tr,
                                                            btnOkOnPress: () {
                                                              Get.back();
                                                            },
                                                          ).show();
                                                          // print('Wrong password provided for that user.');
                                                        }
                                                      }
                                                     }

                                                    }
                                                );
                                              }
                                            ),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),

                                )
                            ),
                            SizedBox(height: Get.height*0.05,),
                             const JUNewsWidget(fontSize: 25,)

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    } );

  }
}


