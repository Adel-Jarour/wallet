import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/customer_details_controller.dart';
import 'package:customer_menu/view/screens/customer_detail/widget/row_strings_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InfoWidget extends StatelessWidget {
  InfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: 30.h,
        bottom: 30.h,
        start: 15.w,
        end: 15.w,
      ),
      child: GetBuilder<CustomerDetailsController>(
        builder: (controller) => controller.loading
            ? CupertinoActivityIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowStringsWidget(
                    text1: "${Strings.nameTextField}:",
                    text2: controller.user.name!,
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
                    text2: controller.totalAmountString,
                    colorText2: (controller.totalAmount == 0)
                        ? Colors.black
                        : (controller.totalAmount < 0)
                            ? Colors.red
                            : Colors.green,
                    endLine: true,
                  ),
                ],
              ),
      ),
    );
  }
}
