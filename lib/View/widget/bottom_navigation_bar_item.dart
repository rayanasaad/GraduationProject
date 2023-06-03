import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:junews/helper/app_colors.dart';



class NavigationTabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Callback? onTap;
  final bool above;

  const NavigationTabItem({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
    required this.above,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width:70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap!();
        },
        child: Container(
          decoration: BoxDecoration(
            color: above? white:Colors.transparent,
            borderRadius: BorderRadius.circular(15)
          ),
          height: 40,
          width: 100,
          child: Column(
            children: [
              Container(
                width: 80,
                child: Icon(
                  icon,
                  color: above
                      ? mainRedColor
                      : Colors.white,
                ),
              ),
              const SizedBox(height: 2,),
              Container(
                width: 80,
                child: Text(
                  label,
                style: TextStyle(
                    color: above
                        ? mainRedColor
                        : Colors.white,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12

                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
