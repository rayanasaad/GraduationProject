import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:junews/View/screens/collage_screen.dart';
import 'package:junews/View/screens/login_screen.dart';
import 'package:junews/View/screens/saved_news_screen.dart';
import 'package:junews/View/widget/bottom_navigation_bar_item.dart';
import 'package:junews/View/widget/setting_item_widget.dart';
import 'package:junews/controller/home_screen_controller.dart';
import 'package:junews/helper/app_colors.dart';
import 'package:junews/helper/helper_widgets.dart';
import 'package:junews/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/theme_controller.dart';
import 'about_screen.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ThemeController());
    GetStorage box = GetStorage();

    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (homeController) {
          return SafeArea(

            child: Scaffold(
              bottomNavigationBar:Container(
                  height: Get.height*0.07,
                  width: Get.width*0.9,
                  margin:  EdgeInsets.symmetric(horizontal: Get.width*0.03,vertical: Get.height*0.01),
                  decoration: BoxDecoration(
                    color: mode == ThemeMode.dark ?grey :mainGreenColor,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      NavigationTabItem(icon:Icons.home,label: "home".tr,above: false,onTap: (){
                        Get.to(const HomeScreen());},),
                      NavigationTabItem(icon:Icons.apartment,label: "collages".tr,above: false,onTap: (){
                        Get.to(const CollageScreen());
                      },),
                      NavigationTabItem(icon:Icons.bookmark,label: "saved".tr,above: false,onTap: (){
                        Get.to(const SavedNewsScreen());
                      },),
                      NavigationTabItem(icon:Icons.person,label: "profile".tr,above: true,onTap: (){},),
                    ],
                  )
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: Get.height*0.45,
                          width: Get.width,
                          decoration:   BoxDecoration(
                            color: mode == ThemeMode.dark ?  grey2 :mainGreenColor.withOpacity(0.5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Get.height*0.15,
                                width: Get.height*0.15,

                                child: CircleAvatar(
                                  child: Container(

                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,

                                          image: DecorationImage(
                                              image: AssetImage(homeController.user.pic),
                                              fit: BoxFit.fill
                                          )
                                      )
                                  ),

                                ),
                              ),
                              SizedBox(height: Get.height*0.02,),
                               Text(
                                 languageCode == "ar"?homeController.user.nameAR:
                                 homeController.user.nameEN,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),),
                              SizedBox(height: Get.height*0.01,),
                               Text(languageCode == "ar"?homeController.user.collegeAR:
                              homeController.user.collegeEN,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),),
                              SizedBox(height: Get.height*0.05,),

                            ],
                          ),
                        ),
                        Positioned(
                          top: Get.height*0.35,
                          child: Column(
                            children: [
                              Container(
                                width: Get.width,
                                height: Get.height*0.65,
                                decoration: BoxDecoration(
                                  color:mode == ThemeMode.dark ? secondDarkColor : white,

                                  borderRadius: BorderRadiusDirectional.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: grey.withOpacity(0.2),
                                      blurRadius: 15.0,
                                      offset:const Offset(0,2),
                                    ),
                                  ],
                                ),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: Get.height*0.03),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:   [
                                         Text(
                                          "settings".tr,
                                          style: TextStyle(
                                              fontSize: 20,
                                            color: mode == ThemeMode.dark ?white:grey
                                          ),
                                        ),
                                        const SizedBox(height: 20,),
                                         InkWell(
                                             onTap: (){
                                               setState(() {
                                                 mode == ThemeMode.light?
                                                     mode = ThemeMode.dark:
                                                     mode = ThemeMode.light;
                                               });
                                             },
                                             child:  SettingItemWidget(icon: Icons.brightness_4_outlined, title: "themeMode".tr,)),
                                         InkWell(
                                             onTap: ()async{
                                               final SharedPreferences shared =
                                                   await SharedPreferences.getInstance();
                                               setState(() {
                                                 languageCode == "en"
                                                     ? languageCode = "ar"
                                                     : languageCode = "en";
                                               });
                                               shared.setString("language_code", languageCode);
                                               Get.updateLocale(Locale(languageCode));
                                             },
                                             child:  SettingItemWidget(icon: Icons.language, title: "language".tr, )),
                                        InkWell(
                                            onTap: (){
                                              Get.to(const AboutScreen());
                                            },
                                            child:  SettingItemWidget(icon: Icons.info_outline, title: "aboutUs".tr, )),
                                       InkWell(
                                         onTap: (){
                                           AwesomeDialog(
                                             padding: const EdgeInsets.all(20),
                                             context: context,
                                             dialogType: DialogType.warning,
                                             animType: AnimType.rightSlide,
                                             title: "logout".tr,
                                             titleTextStyle: const TextStyle(
                                                 color: mainRedColor,
                                                 fontSize: 18,
                                                 fontWeight: FontWeight.w500),
                                             desc: "AreYouSureYouWantToLogOut".tr,
                                             btnCancelText: "cancel".tr,
                                             btnCancelColor: Colors.grey,
                                             btnCancelOnPress: () {
                                               Get.to(const ProfileScreen());
                                             },
                                             btnOkColor: mainRedColor,
                                             btnOkText: 'ok'.tr,
                                             btnOkOnPress: () async {
                                               HelperWidgets.loading();
                                               try {
                                                 await FirebaseAuth.instance.signOut();
                                                 // AuthHelper().logout();
                                                 Get.back();
                                                 Get.deleteAll();
                                                 Get.offAll(const LoginScreen());
                                               } catch (e) {
                                                 print(e);
                                               }
                                             },
                                           ).show();
                                         },
                                           child:  SettingItemWidget(icon: Icons.logout, title: "logout".tr, )
                                       ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}