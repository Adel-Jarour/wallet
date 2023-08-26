import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static showCustomSnackBar({required String title, required String message,Duration? duration})
  {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
      colorText: Colors.white,
      backgroundColor: Colors.green,
      icon: const Icon(Icons.check_circle, color: Colors.white,),
    );
  }


  static showCustomErrorSnackBar({required String title, required String message,Color? color,Duration? duration})
  {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      margin: EdgeInsets.only(top: 10,left: 10,right: 10),
      colorText: Colors.white,
      backgroundColor: color ?? Colors.redAccent,
      icon: Icon(Icons.error, color: Colors.white,),
    );
  }



  static showCustomToast({String? title, required String message,Color? color,Duration? duration}){
    Get.rawSnackbar(
      duration: Duration(seconds: 1),
      titleText: CustomText(txt: title, fontSize: 17.sp, color: Colors.white,),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: color ?? Colors.green,
      onTap: (snack){
        Get.closeAllSnackbars();
      },
      messageText: CustomText(txt: message, fontSize: 17.sp, color: Colors.white,),
      animationDuration: Duration(seconds: 1),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      borderRadius: 8.0,
      snackPosition: SnackPosition.TOP,
    );
  }


  static showCustomErrorToast({String? title, required String message,Color? color,Duration? duration}){
    Get.rawSnackbar(
      duration: Duration(seconds: 1),
      titleText: CustomText(txt: title, fontSize: 17.sp, color: Colors.white,),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: color ?? Colors.redAccent,
      onTap: (snack){
        Get.closeAllSnackbars();
      },
      messageText: CustomText(txt: message, fontSize: 17.sp, color: Colors.white,),
      animationDuration: Duration(seconds: 1),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      borderRadius: 8.0,
      snackPosition: SnackPosition.TOP,
    );
  }
}
