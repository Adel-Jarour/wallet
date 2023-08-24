import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:customer_menu/constance/color_const.dart';
import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/customer_details_controller.dart';
import 'package:customer_menu/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DateDetailWidget extends StatelessWidget {
  const DateDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        bottom: 30.h,
        start: 15.w,
        end: 15.w,
      ),
      child: GetBuilder<CustomerDetailsController>(
        builder: (controller) => Row(
          children: [
            Expanded(
              child: CustomButton(
                high: 45.h,
                txt: controller.fromDates.isNotEmpty
                    ? controller.fromDate
                    : Strings.from,
                onTap: () async {
                  var from = await showCalendarDatePicker2Dialog(
                    context: context,
                    config: CalendarDatePicker2WithActionButtonsConfig(),
                    dialogSize: const Size(325, 400),
                    value: controller.fromDates,
                    borderRadius: BorderRadius.circular(15),
                  );
                  controller.changeFromDateTime(from ?? []);
                },
                colorTxt: ColorConst.primaryColor,
                colorButton: Colors.transparent,
                border: Border.all(
                  color: ColorConst.primaryColor,
                ),
              ),
            ),
            SizedBox(
              width: 30.w,
            ),
            Expanded(
              child: CustomButton(
                high: 45.h,
                txt: controller.todDates.isNotEmpty
                    ? controller.toDate
                    : Strings.to,
                onTap: () async {
                  var to = await showCalendarDatePicker2Dialog(
                    context: context,
                    config: CalendarDatePicker2WithActionButtonsConfig(),
                    dialogSize: const Size(325, 400),
                    value: controller.todDates,
                    borderRadius: BorderRadius.circular(15),
                  );
                  controller.changeToDateTime(to ?? []);
                },
                colorTxt: ColorConst.primaryColor,
                colorButton: Colors.transparent,
                border: Border.all(
                  color: ColorConst.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
