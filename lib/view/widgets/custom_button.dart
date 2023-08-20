import 'package:customer_menu/constance/color_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custem_text.dart';

class CustomButton extends StatelessWidget {
  final String? txt;
  final String? fontFamily;
  final Color? colorButton;
  final Color? colorIfOutLineButtonTrue;
  final Color? colorOutLineButton;
  final Color? colorTxt;
  final Color? overlayColor;
  final Function? onTap;
  final Alignment? alignment;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? width;
  final double? high;
  final double? borderRadius;
  final bool? outLineBorder;
  final bool enabled;
  final double? widthOutLineBorder;
  final Widget? widget;
  final BoxBorder? border;

  const CustomButton({
    required this.txt,
    this.colorButton,
    this.colorTxt = Colors.white,
    required this.onTap,
    this.alignment = Alignment.center,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 16,
    this.width,
    this.high,
    this.borderRadius,
    this.outLineBorder = false,
    this.colorOutLineButton = Colors.white,
    this.widthOutLineBorder = 0,
    this.colorIfOutLineButtonTrue,
    this.overlayColor,
    this.fontFamily,
    this.enabled = false,
    this.widget,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: AnimatedContainer(
        duration: const Duration(
          seconds: 1,
        ),
        width: enabled ? 50.w : width ?? MediaQuery.of(context).size.width,
        height: high ?? 56.h,
        curve: Curves.decelerate,
        decoration: BoxDecoration(
          color: enabled
              ? Colors.transparent
              : colorButton ?? ColorConst.primaryColor,
          borderRadius: enabled
              ? BorderRadius.circular(30)
              : BorderRadius.circular(borderRadius ?? 8.0),
          border: border,
        ),
        alignment: Alignment.center,
        child: enabled
            ? CupertinoActivityIndicator(
                color: Colors.grey,
                radius: 13.r,
              )
            : (widget != null)
                ? widget
                : CustomText(
                    color: colorTxt,
                    txt: txt,
                    fontSize: fontSize ?? 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
      ),
    );
  }
}
