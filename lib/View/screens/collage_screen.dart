import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junews/View/screens/home_screen.dart';
import 'package:junews/View/screens/profile_screen.dart';
import 'package:junews/View/screens/saved_news_screen.dart';
import 'package:junews/View/widget/bottom_navigation_bar_item.dart';
import 'package:junews/controller/home_screen_controller.dart';
import 'package:junews/helper/app_colors.dart';


import '../../main.dart';
import '../widget/college_logo_widget.dart';
import 'collage_screen_detail.dart';

class CollageScreen extends StatelessWidget {
  const CollageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) {
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
                    NavigationTabItem(icon:Icons.apartment,label: "collages".tr,above: true,onTap: (){},),
                    NavigationTabItem(icon:Icons.bookmark,label: "saved".tr,above: false,onTap: (){
                      Get.to( const SavedNewsScreen());
                    },),
                    NavigationTabItem(icon:Icons.person,label: "profile".tr,above: false,onTap: (){
                      Get.to(const ProfileScreen());
                    },),
                  ],
                )
            ),

              body: Padding(
                padding:  EdgeInsets.all(Get.width*0.05),
                child: Column(children: [
                  Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: controller.colleges.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                 controller.separateCollegesNews(collegeName:controller.colleges[index].name);
                                Get.to(CollageDetailsScreen(index: index));
                              },
                              child: CollegeLogoWidget(collegeLogo: controller.colleges[index].logo,
                                collegeName: languageCode == "en"? controller.colleges[index].name:controller.colleges[index].nameAR,
                                isWithName: true,)
                            );
                          }))
                ]),
              ),
            ),
          );
        });
  }
}
