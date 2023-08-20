import 'package:customer_menu/constance/color_const.dart';
import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/add_amount_controller.dart';
import 'package:customer_menu/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class InputOutputWidget extends StatelessWidget {
  InputOutputWidget({
    super.key,
  });

  final AddAmountController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            txt: Strings.incomeButton,
            onTap: () {
              controller.changeComingIndex(0);
            },
            colorButton: controller.incoming
                ? ColorConst.primaryColor
                : Colors.transparent,
            colorTxt: controller.incoming ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: CustomButton(
            txt: Strings.outcomeButton,
            onTap: () {
              controller.changeComingIndex(1);
            },
            colorButton: controller.outComing
                ? ColorConst.primaryColor
                : Colors.transparent,
            colorTxt: controller.outComing ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
