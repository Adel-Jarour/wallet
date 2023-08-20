
import 'package:customer_menu/constance/color_const.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TextFieldType { auth, search }

class CustomTextFormField extends StatelessWidget {
  final String? hintTxt;
  final String? label;
  final String? errorText;
  final FocusNode? focusNode;
  final String? prefix;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function? onPressedPrefixIcon;
  final Function? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final bool? obscureText;
  final bool? prefixVisible;
  final bool? enabled;
  final bool autofocus;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? prefixScale;
  final double? hintFontSize;
  final TextDirection? textDirection;
  final TextFieldType? textFieldType;

  const CustomTextFormField({
    super.key,
    required this.hintTxt,
    this.label,
    this.onPressedPrefixIcon,
    this.onChanged,
    this.keyboardType,
    this.controller,
    this.obscureText = false,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor = Colors.white,
    this.horizontalPadding,
    this.verticalPadding,
    this.prefixIconColor,
    this.suffixIconColor,
    this.enabled = true,
    this.initialValue,
    this.prefix,
    this.focusNode,
    this.prefixScale,
    this.prefixVisible = true,
    this.errorText,
    this.textDirection = TextDirection.rtl,
    this.autofocus = false,
    this.hintFontSize,
    this.textFieldType = TextFieldType.auth,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            txt: hintTxt,
            color: Colors.grey,
            fontSize: 14.sp,
          ),
          SizedBox(width: 20.w,),
          Expanded(
            child: TextFormField(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              focusNode: focusNode,
              autofocus: autofocus,
              initialValue: initialValue,
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "الرجاء إدخال بيانات صحيحة";
                }
                return null;
              },
              onTapOutside: (x) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: onChanged != null ? (str) => onChanged!(str) : null,
              minLines: minLines ?? 1,
              maxLines: maxLines ?? 1,
              maxLength: maxLength,
              style: TextStyle(
                fontFamily: "IBMPlexSansArabic",
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                errorText: errorText,
                errorStyle: TextStyle(
                  fontFamily: "IBMPlexSansArabic",
                  color: Colors.red,
                  fontSize: 13.sp,
                ),
                fillColor: fillColor ?? Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: ColorConst.primaryColor,
                        ),
                      ),
                enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                errorBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: EdgeInsetsDirectional.only(
                  end: horizontalPadding ?? 8.w,
                  top: verticalPadding ?? 19.h,
                  bottom: verticalPadding ?? 19.h,
                  start: horizontalPadding ?? 8.w,
                ),
                prefixIcon: prefixIcon,
                suffixIcon: (suffixIcon != null)
                    ? Padding(
                        padding: EdgeInsetsDirectional.only(end: 40.w),
                        child: suffixIcon,
                      )
                    : null,
                suffixIconColor: suffixIconColor ?? Colors.white,
                prefixIconColor: prefixIconColor ?? Colors.white,
              ),
              enabled: enabled,
              keyboardType: keyboardType,
              obscureText: obscureText!,
            ),
          ),
        ],
      ),
    );
  }
}
