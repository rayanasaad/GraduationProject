import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junews/View/screens/detail_screen.dart';
import 'package:junews/View/widget/NewsList.dart';
import 'package:junews/controller/home_screen_controller.dart';

import '../../helper/app_colors.dart';
import '../../main.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: Container(
              height: Get.height,
              width: Get.width,
              child:  Column(
                children: [
                  Container(
                    height: Get.height*0.15,
                    decoration: BoxDecoration(
                        color: mode == ThemeMode.dark ?  grey2 :mainGreenColor.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight:Radius.circular(20),
                      )
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(right:Get.width*0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          IconButton(onPressed: (){
                            Get.back();},
                              icon: const Icon(Icons.arrow_back_ios,color: white,)),
                          const Text(
                            "Notifications",
                            style: TextStyle(
                              fontSize: 20,
                              color: white,
                              fontWeight: FontWeight.bold

                            ),
                          ),
                             const Icon(Icons.notifications_active,color: white,size: 30,),
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
                                  Get.to(DetailsScreen(newsList: controller.universityNews,index: index,));},
                                child: NewsListTitle(newsList: controller.notifications,index: index,isFromNotifications: true,)) ,
                        separatorBuilder:(context,index)=> SizedBox(height: Get.height*0.015,) ,
                        itemCount: controller.notifications.length),
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
