import 'package:customer_menu/constance/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custem_text.dart';


class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.txt,
    required this.onTap,
    this.color,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  final String txt;
  final Function onTap;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: CustomText(
        txt: txt,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize ?? 18.sp,
        color: color ?? ColorConst.primaryColor,
      ),
    );
  }
}
