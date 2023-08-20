import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  final String? txt;
  final String? fontFamily;
  final double? fontSize;
  final double? height;
  final double? wordSpacing;
  final double? letterSpacing;
  final int? maxLines;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final bool? softWrap;

  const CustomText({
    super.key,
    required this.txt,
    this.height = 1,
    this.fontSize,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.wordSpacing = 1,
    this.decoration = TextDecoration.none,
    this.fontFamily = "IBMPlexSansArabic",
    this.letterSpacing,
    this.maxLines,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txt!.tr,
      maxLines: maxLines ?? 1000,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: decoration,
        fontSize: fontSize ?? 16.sp,
        color: color,
        fontWeight: fontWeight,
        height: height,
        wordSpacing: wordSpacing,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
      ),
      textAlign: textAlign,
      softWrap: softWrap ?? true,
    );
  }
}
