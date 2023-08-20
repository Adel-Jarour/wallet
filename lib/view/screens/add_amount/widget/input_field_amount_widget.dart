import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/add_amount_controller.dart';
import 'package:customer_menu/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InputFieldAmountWidget extends StatelessWidget {
  InputFieldAmountWidget({
    super.key,
  });

  final AddAmountController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: controller.name,
          hintTxt: Strings.nameTextField,
          onChanged: (text) {
            controller.setSearchText(text);
          },
        ),
        SizedBox(
          height: 40.h,
        ),
        CustomTextFormField(
          controller: controller.amount,
          hintTxt: Strings.amountTextField,
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 40.h,
        ),
        CustomTextFormField(
          controller: controller.date,
          hintTxt: Strings.dateTextField,
          keyboardType: TextInputType.datetime,
        ),
      ],
    );
  }
}
