import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowStringsWidget extends StatelessWidget {
  const RowStringsWidget({
    Key? key,
    required this.text1,
    required this.text2,
    this.colorText2,
    this.endLine = false,
  }) : super(key: key);

  final String text1;
  final String text2;
  final Color? colorText2;
  final bool endLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: endLine ? 0 : 30.h),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              txt: text1,
              color: Colors.black,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              width: 15.w,
            ),
            CustomText(
              txt: text2,
              color: colorText2 ?? Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}