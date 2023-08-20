import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/routing/routes.dart';
import 'package:customer_menu/view/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      color: Colors.white,
      padding: EdgeInsetsDirectional.only(
        start: 20.w,
        top: 100.h,
        end: 20.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextButton(
            txt: Strings.addCustomerHome,
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(Routes.addCustomer);
            },
          ),
          SizedBox(
            height: 50.h,
          ),
          CustomTextButton(
            txt: Strings.addAmountHome,
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(Routes.addAmount);
            },
          ),
          // SizedBox(
          //   height: 50.h,
          // ),
          // CustomTextButton(
          //   txt: Strings.searchCustomerHome,
          //   onTap: () {
          //     Navigator.pop(context);
          //     Get.toNamed(Routes.searchCustomer);
          //   },
          // ),
          // SizedBox(
          //   height: 50.h,
          // ),
          // CustomTextButton(
          //   txt: Strings.customerDetailHome,
          //   onTap: () {
          //     Navigator.pop(context);
          //     Get.toNamed(Routes.customerDetails);
          //   },
          // ),
        ],
      ),
    );
  }
}
