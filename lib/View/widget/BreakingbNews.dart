import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junews/View/screens/detail_screen.dart';
import 'package:junews/main.dart';
import 'package:junews/model/news_model.dart';

import '../../helper/app_colors.dart';

class BreakingNewsCard extends StatelessWidget {
  const BreakingNewsCard({Key? key, required this.newsList, required this.index}) : super(key: key);

   final List<NewsDataModel> newsList;
   final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
         Get.to(DetailsScreen(newsList: newsList, index: index,));
      },
      child: Container(
        width: Get.width*0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(newsList[index].urlImage),
          ),
        ),
        child: Container(
          width: Get.width*0.8,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient:  LinearGradient(
              colors: [
               grey.withOpacity(0.2),
                black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: Padding(
            padding:  EdgeInsets.only(left: Get.width*0.05,right:  Get.width*0.05,bottom:  Get.width*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageCode == "en"?
                  newsList[index].title:newsList[index].titleAR,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
