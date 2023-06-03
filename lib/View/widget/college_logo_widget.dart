import 'package:flutter/material.dart';
import 'package:junews/helper/app_colors.dart';
import '../../main.dart';

class CollegeLogoWidget extends StatelessWidget {
   CollegeLogoWidget({Key? key, required this.collegeLogo,  this.collegeName,this.size, required this.isWithName}) : super(key: key);
final String collegeLogo;
 String? collegeName;
final bool isWithName;
 double? size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        decoration: BoxDecoration(
            color:mode == ThemeMode.dark ?  secondDarkColor : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0,1.0),
                blurRadius: 2,

              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                collegeLogo,
                height:size?? 80,
                width:size?? 80,
              ),
            ),
            isWithName?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                collegeName??"",
                textAlign: TextAlign.center,
                maxLines: 2,
                style:  TextStyle(
                  fontSize: 13,
                  color: mode == ThemeMode.dark ? white:grey2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ):Container(),
          ],
        ),
      ),
    );
  }
}
