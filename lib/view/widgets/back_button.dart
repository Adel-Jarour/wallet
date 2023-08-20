import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
    this.onTap,
  });

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        (onTap != null) ? onTap!() : Get.back();
      },
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        size: 25.r,
        color: Colors.black,
      ),
    );
  }
}
