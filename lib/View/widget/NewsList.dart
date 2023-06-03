import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junews/controller/home_screen_controller.dart';

import 'package:junews/helper/app_colors.dart';
import 'package:junews/model/news_model.dart';

import '../../main.dart';

class NewsListTitle extends StatelessWidget {
  NewsListTitle({Key? key, required this.index,this.isFromNotifications, required this.newsList}) : super(key: key);
  bool? isFromNotifications;
  final List<NewsDataModel> newsList;
  final int index;
  @override
  Widget build(BuildContext context) {
  return GetBuilder<HomeScreenController>(
    init: HomeScreenController(),
    builder: (controller) {
      return Padding(
        padding:  EdgeInsets.symmetric(horizontal:Get.width*0.05),
        child: Container(
        width: Get.width,
          height: Get.height*0.12,
          decoration: BoxDecoration(
              color:mode == ThemeMode.dark ?  secondDarkColor : white,
              borderRadius: BorderRadius.circular(10),
              boxShadow:  [
                BoxShadow(
                  color: isFromNotifications==true?mainGreenColor.withOpacity(0.5):Colors.grey,
                  offset: const Offset(0,1.0),
                  blurRadius: 2,

                )
              ]    ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                  child:Container(
                    height: Get.height*0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage(newsList[index].urlImage),
                      fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
              ),
              Flexible(
                flex:6 ,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Text(
                         languageCode == "en"?
                         newsList[index].title:newsList[index].titleAR,
                      maxLines: 2,
                      style:  TextStyle(
                        color:mode == ThemeMode.dark ?Colors.white:grey,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                      ),
                         SizedBox(height: Get.height*0.005,),
                        Text(
                          "seeMore".tr,
                          style:  TextStyle(
                            color:grey2.withOpacity(0.5),
                            fontSize: 12
                          ),
                        ),

                      ],


                    ),
                  ),

              ),
               const Spacer(),
               Flexible(
                flex:1 ,
                  child: Padding(
                    padding: EdgeInsets.only(top:Get.height*0.02),
                    child: InkWell(
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
                    ),
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
