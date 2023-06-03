import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junews/View/screens/collage_screen.dart';
import 'package:junews/View/screens/profile_screen.dart';
import 'package:junews/View/widget/NewsList.dart';
import 'package:junews/View/widget/bottom_navigation_bar_item.dart';
import 'package:junews/controller/home_screen_controller.dart';
import 'package:junews/helper/app_colors.dart';

import '../../main.dart';
import 'detail_screen.dart';
import 'home_screen.dart';

class SavedNewsScreen extends StatelessWidget {
  const SavedNewsScreen({Key? key}) : super(key: key);

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
                      NavigationTabItem(icon:Icons.apartment,label: "collages".tr,above: false,onTap: (){
                        Get.to(const CollageScreen());
                      },),
                      NavigationTabItem(icon:Icons.bookmark,label: "saved".tr,above: true,onTap: (){},),
                      NavigationTabItem(icon:Icons.person,label: "profile".tr,above: false,onTap: (){
                        Get.to(const ProfileScreen());
                      },),
                    ],
                  )


              ),

                body: Container(
                    height: Get.height,
                    width: Get.width,
                    child:  Column(
                      children: [
                        Container(
                          height: Get.height*0.15,
                          decoration: BoxDecoration(
                              color:mode == ThemeMode.dark ? grey2 : mainGreenColor.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight:Radius.circular(20),
                              )
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal:Get.width*0.1),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                 Text(
                                  "savedNews".tr,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: white,
                                    fontWeight: FontWeight.bold

                                  ),
                                ),
                                InkWell(
                                    onTap: (){
                                      controller.savedNews.clear();
                                      controller.update();
                                    },
                                    child: controller.savedNews.isEmpty?
                                    const Icon(Icons.bookmark_border,color:white,size: 30,):
                                    const Icon(Icons.bookmark,color:white,size: 30,)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height*0.02,),
                        Expanded(
                          child: ListView.separated(
                              itemBuilder:(context,index)=>
                                  InkWell(
                                      onTap: (){
                                        Get.to(DetailsScreen( newsList: controller.savedNews,index: index,));},
                                      child: NewsListTitle(newsList:controller.savedNews,index: index,isFromNotifications: false,)) ,
                              separatorBuilder:(context,index)=> SizedBox(height: Get.height*0.015,) ,
                              itemCount: controller.savedNews.length),
                        ),

                      ],
                    )
                ),

            ),
          );
        }
    );
  }
}
