import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:junews/controller/about_screen_controller.dart';
import 'package:junews/helper/app_colors.dart';

import '../../main.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<AboutScreenController>(
      init: AboutScreenController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: SizedBox(
                height: Get.height,
                width: Get.width,
                child:  Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: Get.height*0.15,
                            decoration: BoxDecoration(
                                color:mode == ThemeMode.dark ? grey2 : mainGreenColor.withOpacity(0.5),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight:Radius.circular(20),
                                )
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal:Get.width*0.05),
                              child: Row(
                                children: [
                                  IconButton(onPressed: (){
                                    Get.back();},
                                      icon: const Icon(Icons.arrow_back_ios,color: white,)),
                                   SizedBox(width: Get.width*0.15,),
                                    Text(
                                     "aboutUs".tr,
                                     style: const TextStyle(
                                         fontSize: 20,
                                         color: white,
                                         fontWeight: FontWeight.bold

                                     ),
                                   ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height*0.05,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
                      child:  Text(controller.aboutText,
                      style: TextStyle(
                        color:mode == ThemeMode.dark ?white:grey
                      ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.05,),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width*0.1),
                        child: Column(
                          children: [
                            for(int i = 0; i<4; i++)
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: Get.height*0.01),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: Get.height*0.09,
                                    width: Get.height*0.08,

                                    child: CircleAvatar(
                                      child: Container(

                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,

                                          image: DecorationImage(
                                            image: AssetImage(controller.teamMembers[i]["pic"],),
                                            fit: BoxFit.fill
                                          )
                                        )
                                      ),

                                    ),
                                  ),
                                  SizedBox(width: Get.width*0.05,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                       Text(
                                         languageCode =="en"?
                                         controller.teamMembers[i]["name"]:
                                         controller.teamMembers[i]["nameAR"],
                                        style: const TextStyle(
                                            color: grey2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      // SizedBox(height: Get.height*0.01,),
                                      //
                                      // Text("Computer Science",
                                      //   style: TextStyle(
                                      //       color:grey2,
                                      //       fontSize: 15,
                                      //   ),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
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
