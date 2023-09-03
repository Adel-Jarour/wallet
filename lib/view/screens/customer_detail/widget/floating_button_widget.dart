import 'package:customer_menu/controller/customer_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDetailsController>(
      builder: (controller) => (controller.endElements)
          ? SizedBox()
          : InkWell(
              onTap: () {
                controller.increaseLength(context);
              },
              child: Container(
                width: 40.w,
                height: 40.h,
                alignment: Alignment.center,
                child: Icon(Icons.arrow_downward),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white60,
                ),
              ),
            ),
    );
  }
}
