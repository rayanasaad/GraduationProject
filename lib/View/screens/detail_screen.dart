import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junews/controller/home_screen_controller.dart';
import 'package:junews/model/news_model.dart';

import '../../helper/app_colors.dart';
import '../../main.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.newsList, required this.index}) : super(key: key);
   final List<NewsDataModel> newsList;
   final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: Get.height*0.45,
                      width: Get.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(newsList[index].urlImage),
                          fit: BoxFit.cover
                        )
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
                                color: mode == ThemeMode.dark ?  secondDarkColor :white,

                                borderRadius: BorderRadiusDirectional.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: grey2.withOpacity(0.5),
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
                                  children: [
                                    Text(
                                      languageCode == "en"?
                                      newsList[index].title:newsList[index].titleAR,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: mainGreenColor,
                                      ),
                                    ),
                                     SizedBox(height:Get.height*0.02 ),
                                    Row(
                                      children: [
                                        GetBuilder<HomeScreenController>(
                                          init: HomeScreenController(),
                                          builder: (controller) {
                                            return InkWell(
                                            onTap: (){
                                        controller.onTapSaveNews(newsList: newsList, index: index);
                                        },
                                          child: controller.isSaveNews(newsList: newsList, index: index) ?
                                            const Icon(
                                              Icons.bookmark,
                                              color: mainGreenColor,
                                            )
                                                :
                                              const Icon(
                                                Icons.bookmark_border,
                                                color: grey2,
                                              ),
                                            );
                                          }
                                        ),
                                        const SizedBox(width: 5),
                                         Text(
                                          "save".tr,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color:grey2

                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: (){
                                          },
                                          child:  Row(
                                            children: [
                                              const Icon(
                                                Icons.play_circle_outline,
                                                size: 30,
                                                color: mainRedColor,

                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                "play".tr,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                    color:grey2

                                              ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height:Get.height*0.04 ),
                                    Text(
                                      languageCode == "en"?
                                      newsList[index].content:newsList[index].contentAR,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: grey2,
                                      ),
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
      ),
    );
  }
}

