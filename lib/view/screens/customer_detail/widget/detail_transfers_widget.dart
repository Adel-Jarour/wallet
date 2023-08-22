import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailTransfersWidget extends StatelessWidget {
  const DetailTransfersWidget({
    Key? key,
    required this.amount,
    required this.date,
  }) : super(key: key);

  final String amount;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(vertical: 10.h, horizontal: 5.w),
      margin: EdgeInsetsDirectional.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                txt: Strings.date,
                color: Colors.black,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: 15.w,
              ),
              CustomText(
                txt: date,
                color: Colors.blueGrey,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: 20.w,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  txt: Strings.amount,
                  color: Colors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  width: 15.w,
                ),
                CustomText(
                  txt: amount,
                  color: Colors.blueAccent,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
