import 'package:customer_menu/constance/color_const.dart';
import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/customer_details_controller.dart';
import 'package:customer_menu/view/screens/customer_detail/widget/detail_transfers_widget.dart';
import 'package:customer_menu/view/screens/customer_detail/widget/row_strings_widget.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RowStringsWidget(
                  text1: "${Strings.nameTextField}:",
                  text2: controller.user.name!,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomText(
                        txt: "${Strings.notesTextField}:",
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Expanded(
                      child: CustomText(
                        txt: (controller.user.note != null &&
                                controller.user.note!.isNotEmpty)
                            ? controller.user.note!
                            : Strings.nothings,
                        color: Colors.black,
                        fontSize: 20.sp,
                        letterSpacing: 1,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                RowStringsWidget(
                  text1: Strings.sumInputsDetail,
                  text2: "${controller.sumInputs}",
                ),
                RowStringsWidget(
                  text1: Strings.sumOutputsDetail,
                  text2: "${controller.sumOutputs}",
                ),
                RowStringsWidget(
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