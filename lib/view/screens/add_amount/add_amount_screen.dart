import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/add_amount_controller.dart';
import 'package:customer_menu/view/screens/add_amount/widget/input_field_amount_widget.dart';
import 'package:customer_menu/view/screens/add_amount/widget/input_output_widget.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:customer_menu/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddAmountScreen extends StatelessWidget {
  const AddAmountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          txt: Strings.addAmountHome,
          color: Colors.white,
          fontSize: 20.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 20.w,
            vertical: 40.h,
          ),
          child: GetBuilder<AddAmountController>(
            init: AddAmountController(),
            builder: (controller) => Column(
              children: [
                InputOutputWidget(),
                SizedBox(
                  height: 50.h,
                ),
                InputFieldAmountWidget(),
                SizedBox(
                  height: 50.h,
                ),
                CustomButton(
                  txt: controller.updateAmount
                      ? Strings.updateButton
                      : Strings.saveButton,
                  onTap: () {
                    controller.updateAmount
                        ? controller.performUpdate()
                        : controller.performSave();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
