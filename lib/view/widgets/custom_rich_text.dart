import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.question,
    required this.txt,
    required this.onTap,
    this.questionFontSize,
    this.questionColor,
    this.questionFontWeight,
    this.txtFontSize,
    this.txtColor,
    this.txtFontWeight,
    this.textDecoration,
    this.height,
  });

  final String question;
  final String txt;
  final Function onTap;
  final double? height;
  final double? questionFontSize;
  final double? txtFontSize;
  final Color? questionColor;
  final Color? txtColor;
  final FontWeight? questionFontWeight;
  final FontWeight? txtFontWeight;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: question,
        style: TextStyle(
          fontSize: questionFontSize ?? 16.sp,
          color: questionColor ?? Colors.black,
          fontFamily: 'Sora',
          fontWeight: questionFontWeight ?? FontWeight.w700,
          height: height,
        ),
        children: [
          TextSpan(
            text: txt,
            style: TextStyle(
              fontSize: txtFontSize ?? 16.sp,
              color: txtColor ?? const Color(0xff483EA8),
              fontFamily: 'Sora',
              fontWeight: txtFontWeight ?? FontWeight.w700,
              decoration: textDecoration ?? TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {
              onTap();
            },
          ),
        ],
      ),
    );
  }
}
