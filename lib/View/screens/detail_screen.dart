import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junews/controller/detils_screen_controller.dart';
import 'package:junews/controller/home_screen_controller.dart';
import 'package:junews/model/news_model.dart';

import '../../helper/app_colors.dart';
import '../../main.dart';


class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.newsList, required this.index}) : super(key: key);
   final List<NewsDataModel> newsList;
   final int index;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsScreenController>(
      init: DetailsScreenController(),
      builder: (mainCon) {
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
                              image: AssetImage(widget.newsList[widget.index].urlImage),
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
                                          widget.newsList[widget.index].title:widget.newsList[widget.index].titleAR,
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
                                            controller.onTapSaveNews(newsList: widget.newsList, index: widget.index);
                                            },
                                              child: controller.isSaveNews(newsList: widget.newsList, index: widget.index) ?
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
                                              onTap: ()async{
                                              if(mainCon.isPlayed){
                                                mainCon.player.stop();

                                              }
                                              else{
                                               await mainCon.setAudio(audio: languageCode== "en"?
                                                widget.newsList[widget.index].audioFileEN:
                                                widget.newsList[widget.index].audioFileAR
                                                );
                                               mainCon.player.play();
                                              }

                                              mainCon.isPlayed = !mainCon.isPlayed;
mainCon.update();

                                              },
                                              child:  Row(
                                                children: [
                                                  mainCon.isPlayed?
                                               const Icon(

                                              Icons.stop_circle_sharp,
                                                size: 30,
                                                color: mainRedColor,

                                              ) :const Icon(

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
                                          widget.newsList[widget.index].content:widget.newsList[widget.index].contentAR,
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
    );
  }
}

