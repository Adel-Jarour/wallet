import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:customer_menu/constance/color_const.dart';
import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/add_amount_controller.dart';
import 'package:customer_menu/view/widgets/custom_button.dart';
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
          errorText: controller.errorName,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              txt: Strings.dateTextField,
              width: controller.dateTime.isNotEmpty ? 110.w : 150.w,
              onTap: () async {
                var results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(),
                  dialogSize: const Size(325, 400),
                  value: controller.dateTime,
                  borderRadius: BorderRadius.circular(15),
                );
                controller.changeDateTime(results ?? []);
              },
              colorButton: Colors.transparent,
              colorTxt: controller.isSelectedDate!
                  ? ColorConst.primaryColor
                  : Colors.red,
              border: Border.all(
                color: controller.isSelectedDate!
                    ? ColorConst.primaryColor
                    : Colors.red,
              ),
            ),
            if (controller.selectedDate.isNotEmpty)
              Expanded(
                child: CustomTextFormField(
                  hintTxt: '',
                  controller: controller.date,
                  enabled: false,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
