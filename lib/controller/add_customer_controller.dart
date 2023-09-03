import 'package:customer_menu/components/custom_snackbar.dart';
import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/home_controller.dart';
import 'package:customer_menu/data/local/db_controller/db_helper.dart';
import 'package:customer_menu/routing/routes.dart';
import 'package:flutter/material.dart';
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
      CustomSnackBar.showCustomToast(
        title: Strings.addCustomerHome,
        message: Strings.successToAddCustomer,
      );
      Get.toNamed(Routes.home);
    } catch (e) {
      if (e is DatabaseException && e.getResultCode() == 2067) {
        CustomSnackBar.showCustomErrorToast(
          title: Strings.addCustomerHome,
          message: Strings.failedToAddCustomer,
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
    formKey.currentState?.dispose();
  }
}
