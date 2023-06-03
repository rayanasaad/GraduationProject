import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junews/controller/profile_screen_controller.dart';
import 'package:junews/helper/app_colors.dart';


import '../../main.dart';

class SettingItemWidget extends StatelessWidget {
  const SettingItemWidget({Key? key, required this.icon, required this.title, }) : super(key: key);
final IconData icon;
final String title;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileScreenController>(
      init: ProfileScreenController(),
      builder: (controller) {
        return Column(
          children: [
            Container(
              height: Get.height*0.1,
              width: Get.width*0.9,
               color:Colors.transparent,
              child:Row(
                children: [
                  Container(
                    height: Get.height*0.08,
                    width: Get.height*0.08,
                    decoration: BoxDecoration(
                      color:mainRedColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:  Icon(icon,
                      color: mainRedColor.withOpacity(0.7),
                      size: 30,
                    ),
                  ),
                  SizedBox(width: Get.width*0.05,),
                   Text(title,
                    style:  TextStyle(
                      color:mode == ThemeMode.dark ?white:grey,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                   Icon(Icons.arrow_forward_ios,
                  color:mode == ThemeMode.dark ?white:grey ,
                  ),
                ],
              ) ,
            ),
          ],
        );
      }
    );
  }
}
