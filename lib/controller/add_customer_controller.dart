import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/home_controller.dart';
import 'package:customer_menu/data/local/db_controller/db_helper.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class AddCustomerController extends GetxController {
  late TextEditingController name;
  late TextEditingController note;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final HomeController homeController = Get.find();

  bool checkData() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  bool isSubmit = false;

  saveDataToDB() async {
    try {
      await DatabaseHelper().addUser(
        name.text,
        note.text,
      );
      Get.snackbar(
        "",
        "",
        icon: const Icon(Icons.verified, color: Colors.green),
        snackPosition: SnackPosition.TOP,
        titleText: CustomText(
          txt: Strings.addCustomerHome,
          fontSize: 18.sp,
        ),
        messageText: CustomText(
          txt: Strings.successToAddCustomer,
          color: Colors.black,
          fontSize: 15.sp,
        ),
        padding: EdgeInsets.all(20.0.r),
        borderRadius: 27.0,
        backgroundColor: Colors.white60,
      );
    } catch (e) {
      if (e is DatabaseException && e.getResultCode() == 2067) {
        Get.snackbar(
          "",
          "",
          icon: const Icon(Icons.error, color: Colors.red),
          snackPosition: SnackPosition.TOP,
          titleText: CustomText(
            txt: Strings.addCustomerHome,
            fontSize: 18.sp,
          ),
          messageText: CustomText(
            txt: Strings.failedToAddCustomer,
            color: Colors.black,
            fontSize: 15.sp,
          ),
          padding: EdgeInsets.all(20.0.r),
          borderRadius: 27.0,
          backgroundColor: Colors.white60,
        );
      } else {
        rethrow;
      }
    }
  }

  void performAdd() async {
    if (checkData()) {
      isSubmit = true;
      update();
      await saveDataToDB();
      isSubmit = false;
      name.clear();
      note.clear();
      homeController.getUser();
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    name = TextEditingController();
    note = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    note.dispose();
  }
}
