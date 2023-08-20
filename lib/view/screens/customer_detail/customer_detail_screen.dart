import 'package:customer_menu/constance/color_const.dart';
import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/customer_details_controller.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          txt: Strings.customerDetailHome,
          color: Colors.white,
          fontSize: 20.sp,
        ),
      ),
      body: GetBuilder<CustomerDetailsController>(
        init: CustomerDetailsController(),
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              top: 30.h,
              bottom: 10.h,
              start: 15.w,
              end: 15.w,
            ),
            child: Column(
              children: [
                RowStrings(
                  text1: "${Strings.nameTextField}:",
                  text2: controller.user.name!,
                ),
                RowStrings(
                  text1: Strings.sumInputsDetail,
                  text2: "${controller.sumInputs}",
                ),
                RowStrings(
                  text1: Strings.sumOutputsDetail,
                  text2: "${controller.sumOutputs}",
                ),
                RowStrings(
                  text1: Strings.totalAmount,
                  text2: controller.totalAmount.toStringAsFixed(2),
                  colorText2: (controller.totalAmount == 0)
                      ? Colors.black
                      : (controller.totalAmount < 0)
                          ? Colors.red
                          : Colors.green,
                ),
                SizedBox(
                  height: 50.h,
                ),
                CustomText(
                  txt: Strings.allInputOperations,
                  color: ColorConst.primaryColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 20.h,
                ),
                if (controller.userInputs.isEmpty)
                  CustomText(
                    txt: Strings.nothings,
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ...controller.userInputs
                    .map(
                      (e) => DetailTransfersWidget(
                        date: e.date ?? '',
                        amount: e.input ?? '',
                      ),
                    )
                    .toList(),
                SizedBox(
                  height: 50.h,
                ),
                CustomText(
                  txt: Strings.allOutputOperations,
                  color: ColorConst.primaryColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 20.h,
                ),
                if (controller.userOutputs.isEmpty)
                  CustomText(
                    txt: Strings.nothings,
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ...controller.userOutputs
                    .map(
                      (e) => DetailTransfersWidget(
                        date: e.date ?? '',
                        amount: e.output ?? '',
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RowStrings extends StatelessWidget {
  const RowStrings({
    Key? key,
    required this.text1,
    required this.text2,
    this.colorText2,
  }) : super(key: key);

  final String text1;
  final String text2;
  final Color? colorText2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 20.h),
      child: Row(
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
          ),
        ],
      ),
    );
  }
}

class DetailTransfersWidget extends StatelessWidget {
  const DetailTransfersWidget({
    Key? key,
    required this.amount,
    required this.date,
    this.colorText2,
  }) : super(key: key);


  final String amount;
  final String date;
  final Color? colorText2;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(vertical: 10.h, horizontal: 5.w),
      margin: EdgeInsetsDirectional.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      child: Row(
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
            color: colorText2 ?? Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            width: 40.w,
          ),
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
            color: colorText2 ?? Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
