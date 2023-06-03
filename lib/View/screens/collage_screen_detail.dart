import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junews/controller/home_screen_controller.dart';
import 'package:junews/helper/app_colors.dart';
import '../../main.dart';
import '../widget/NewsList.dart';
import 'detail_screen.dart';
class CollageDetailsScreen extends StatelessWidget {
   const CollageDetailsScreen( {Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder <HomeScreenController>(
        init: HomeScreenController(),
    builder :(controller){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Get.height*0.32,
              child: Stack(
                children: [
                  Container(
                        height: Get.height*0.28,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1),
                            image:  DecorationImage(
                                image: AssetImage(controller.colleges[index].image),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                  Padding(
                    padding:  const EdgeInsetsDirectional.only(start: 5,top: 5),
                    child: InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back_ios,
                      color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: Get.height*0.23,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal:Get.width*0.05,
                      ),
                      child: Container(
                        width: Get.width*0.9,
                        height: Get.height*0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(15),
                          boxShadow:const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1.0,
                              offset:Offset(0,2),
                            ),
                          ],
                          color:mode == ThemeMode.dark ?  mainDarkColor : Colors.white,
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: Text(
                              languageCode == "en"?
                              controller.colleges[index].name:controller.colleges[index].nameAR,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style:  const TextStyle(
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis,
                                color: mainGreenColor

                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height*0.02,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: Get.width*0.05),
              child:   Row(
                children: [
                  Text(
                    "collegeNews".tr,
                    style: TextStyle(
                        fontSize: 20,
                        color: grey2,

                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height*0.02,),
            Expanded(
              child:controller.collegeData.isEmpty?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.05),
                        child: Image.asset("assets/images/emptyNews.png",
                        width: Get.width*0.6,
                        ),
                      ),
                      SizedBox(height: Get.height*0.05,),
                      const Text("There is no news until now",
                      style: TextStyle(
                        color: grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                    ],
                  )
                  :ListView.separated(
                  itemBuilder:(context,index)=>
                      InkWell(
                      onTap: (){
                        Get.to(DetailsScreen(newsList: controller.collegeData, index: index,));
                      },
                          child: NewsListTitle(newsList:controller.collegeData,index: index,)) ,
                  separatorBuilder:(context,index)=> SizedBox(height: Get.height*0.01,) ,
                  itemCount: controller.collegeData.length),
            ),

          ],
        ),
      ),



      );

    } );

  }
}
