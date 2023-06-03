import 'package:flutter/material.dart';
import 'package:junews/helper/app_colors.dart';

class JUNewsWidget extends StatelessWidget {
  const JUNewsWidget({Key? key, required this.fontSize}) : super(key: key);
final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Text(
          "JU",
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              letterSpacing: 10,
              color:mainRedColor
          ),
        ),
        const SizedBox(width: 8,),
        Text(
          "NEWS",
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 10,
            color:mainGreenColor,
          ),
        ),
      ],
    );
  }
}
