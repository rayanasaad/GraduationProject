import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junews/View/screens/all_news_call.dart';
import 'package:junews/View/screens/collage_screen.dart';
import 'package:junews/View/screens/collage_screen_detail.dart';
import 'package:junews/View/screens/detail_screen.dart';
import 'package:junews/View/screens/notifications_screen.dart';
import 'package:junews/View/screens/profile_screen.dart';
import 'package:junews/View/screens/saved_news_screen.dart';
import 'package:junews/View/widget/BreakingbNews.dart';
import 'package:junews/View/widget/NewsList.dart';
import 'package:junews/View/widget/bottom_navigation_bar_item.dart';
import 'package:junews/View/widget/college_logo_widget.dart';
import 'package:junews/View/widget/ju_news_widget.dart';
import 'package:junews/controller/home_screen_controller.dart';
import 'package:junews/helper/app_colors.dart';
import 'package:junews/helper/helper_widgets.dart';
import 'package:junews/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder <HomeScreenController>(
        init: HomeScreenController(),
        builder :(controller){
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false, // remove icon back
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title:   const Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/smju.png"),
                    radius: 23,
                  ),
                  SizedBox(width: 8,),
                  JUNewsWidget(fontSize: 20,)
                ],
              ),
              actions: [
                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 20),
                  child: CircleAvatar(
                    backgroundColor: Colors.red.shade400,
                    child: IconButton(
                        onPressed: ()async{
                             Get.to(const NotificationsScreen());

                          // for(int i = 0; i<controller.allNews.length;i++) {
                          // await FirebaseFirestore.instance.collection("news").doc("$i").set(controller.allNews[i].toJson());
                          // }
                        },
                        icon:const Icon(Icons.notification_add,color: Colors.white,)),
                  ),
                )
              ],
            ),

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
                    NavigationTabItem(icon:Icons.home,label: "home".tr,above: true,onTap: (){},),
                    NavigationTabItem(icon:Icons.apartment,label: "collages".tr,above: false,onTap: (){
                      Get.to(const CollageScreen());},),
                    NavigationTabItem(icon:Icons.bookmark,label: "saved".tr,above: false,onTap: (){
                      Get.to(const SavedNewsScreen());},),
                    NavigationTabItem(icon:Icons.person,label: "profile".tr,above: false,onTap: (){
                      Get.to(const ProfileScreen());
                    },),
                  ],
                )
            ),

            body:
            StreamBuilder(
              stream: controller.readNewsData(),
              builder: (context,snapshot) {
              if(snapshot.hasData){
              controller.allNews =snapshot.data!;
              controller.separateNews();
              }
                  return StreamBuilder(
                    stream: controller.readCollegesData(),
                    builder: (context,snapshot1) {
                      if(snapshot1.hasData){
                        controller.colleges =snapshot1.data!;
                        controller.isLoading = false;
                      }
                    return controller.isLoading?
                    const Center(child: CupertinoActivityIndicator()):
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal:Get.width*0.05),
                                      child:  Text(
                                        "universityNews".tr,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: grey2,

                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height*0.01,),
                                    CarouselSlider.builder(
                                      itemCount: controller.universityNews.length,
                                      itemBuilder: (context,index,id)=>
                                          BreakingNewsCard(newsList:controller.universityNews,index: index,),
                                      options: CarouselOptions(aspectRatio: 16/9,
                                          enableInfiniteScroll: false,
                                          enlargeCenterPage: true),),
                                    SizedBox(height: Get.height*0.02,),
                                    SizedBox(
                                      height: Get.height*0.09,
                                      width: Get.width,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(horizontal:Get.width*0.05),
                                          child: Row(
                                            children: [
                                              for(int i =0; i<controller.colleges.length;i++)
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                  child: SizedBox(
                                                      width: Get.width*0.2,
                                                      child: InkWell(
                                                          onTap: (){
                                                             controller.separateCollegesNews(collegeName:controller.colleges[i].name);
                                                            Get.to(CollageDetailsScreen(index: i));
                                                          },
                                                          child: CollegeLogoWidget(collegeLogo: controller.colleges[i].logo,isWithName: false,size: 45,))),
                                                )

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height*0.02,),

                                    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal:Get.width*0.05),
                                      child: Row(
                                        children: [
                                           Text(
                                            "recentNews".tr,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: grey2,
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: (){
                                              Get.to(const AllNews());
                                            },
                                            child: Text(
                                              "seeAll".tr,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: mainRedColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: Get.height*0.01,),
                                    Expanded(
                                      child: ListView.separated(
                                          itemBuilder:(context,index)=>
                                              InkWell(
                                                  onTap: (){
                                                    Get.to(DetailsScreen(newsList: controller.collegesNews,index: index,));
                                                  },
                                                  child: NewsListTitle(newsList:controller.collegesNews,index: index,)) ,
                                          separatorBuilder:(context,index)=> SizedBox(height: Get.height*0.015,) ,
                                          itemCount: 10),
                                    ),
                                  ],
                                );
                  }

                  );
                }

          ));
        }

    );}
}
