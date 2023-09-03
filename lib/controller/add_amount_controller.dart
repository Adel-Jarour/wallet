import 'package:customer_menu/components/custom_snackbar.dart';
import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/customer_details_controller.dart';
import 'package:customer_menu/controller/home_controller.dart';
import 'package:customer_menu/data/local/db_controller/db_helper.dart';
import 'package:customer_menu/data/models/amount_model.dart';
import 'package:customer_menu/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAmountController extends GetxController {
  bool updateAmount = false;
  AmountModel? amountModel;

  void checkUpdate() async {
    if (Get.arguments != null) {
      AmountModel? amountModel = Get.arguments[0];
      if (amountModel != null) {
        if (amountModel.input != null) {
          incoming = true;
          outComing = false;
        } else {
          incoming = false;
          outComing = true;
        }

        var user = await DatabaseHelper().getUser(amountModel.uid);
        selectedUser = UserModel.fromMap(user![0]);

        this.amountModel = amountModel;

        isSelectedDate = true;
        dateTime = [DateTime.now()];
        selectedDate = amountModel.date.toString();
        name.text = selectedUser!.name!;
        amount.text = (amountModel.input ?? amountModel.output)!;
        date.text = amountModel.date!;
        note.text = amountModel.note ?? '';
        updateAmount = true;
      } else {
        updateAmount = false;
      }
    } else {
      incoming = true;
      outComing = false;
      updateAmount = false;
    }
    update();
  }

  final HomeController homeController = Get.find();

  late bool incoming;
  late bool outComing;

  void changeIncoming() {
    if (!incoming) {
      incoming = true;
      outComing = false;
    }
    update();
  }

  void changeOutComing() {
    if (!outComing) {
      outComing = true;
      incoming = false;
    }
    update();
  }

  var searchText = '';

  List<UserModel> filteredUsers = [];

  void setSearchText(String text) {
    searchText = text;
    selectedUser = UserModel.clear();
    getFilterUsers();
    update();
  }

  bool? isSelectedUser;
  late UserModel? selectedUser;

  bool checkIsSelectedUser() {
    if (isSelectedUser != null) {
      return isSelectedUser!;
    }
    return true;
  }

  void setSelectedUser(UserModel user) {
    selectedUser = user;
    filteredUsers = [];
    name.text = user.name!;
    isSelectedUser = true;
    update();
  }

  List<UserModel> users = [];
  bool loading = false;

  Future getFilterUsers() async {
    filteredUsers = [];
    loading = true;
    update();
    if (name.text.isNotEmpty && name.text != '') {
      final res = await DatabaseHelper().getAllUsers();
      for (var i in res ?? []) {
        final user = UserModel.fromMap(i);
        if (user.name!.toLowerCase().startsWith(searchText)) {
          filteredUsers.add(user);
        }
      }
      if (filteredUsers.isEmpty) {
        nameError = 'لا يوجد شخص بهذا الإسم';
      } else {
        nameError = null;
      }
    } else {
      nameError = 'الرجاء كتابة إسم';
    }
  }

  late TextEditingController name;
  late TextEditingController amount;
  late TextEditingController date;
  late TextEditingController note;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? nameError = null;

  bool checkSelectedUser() {
    if (selectedUser!.name!.isNotEmpty) {
      nameError = null;
      update();
      return true;
    } else if (name.text.isNotEmpty) {
      nameError = 'الرجاء إختيار إسم';
      isSelectedUser = false;
      update();
      return false;
    }
    nameError = 'الرجاء كتابة إسم';
    update();
    return false;
  }

  bool checkData() {
    bool date = checkSelectedDate();
    if (formKey.currentState!.validate() && checkSelectedUser() && date) {
      return true;
    }
    return false;
  }

  saveDataToDB() async {
    if (incoming) {
      await DatabaseHelper().insertAmount(
        selectedUser?.id ?? 0,
        selectedDate,
        note: note.text,
        input: amount.text,
      );
    } else {
      await DatabaseHelper().insertAmount(
        selectedUser?.id ?? 0,
        selectedDate,
        note: note.text,
        output: amount.text,
      );
    }
  }

  bool isSubmit = false;

  void performSave() async {
    print('performSave...');
    if (checkData()) {
      isSubmit = true;
      update();
      await saveDataToDB();
      CustomSnackBar.showCustomToast(
        title: Strings.addAmountHome,
        message: Strings.successAddAmount,
      );
      isSubmit = false;
      name.clear();
      amount.clear();
      date.clear();
      note.clear();
      homeController.getTotal();
    }
  }

  void performUpdate() async {
    print('performUpdate...');
    if (checkData()) {
      isSubmit = true;
      update();
      if (incoming) {
        await DatabaseHelper().updateAmount(amountModel!.id, date.text,
            input: amount.text, note: note.text);
      } else {
        await DatabaseHelper().updateAmount(amountModel!.id, date.text,
            output: amount.text, note: note.text);
      }
      CustomerDetailsController customerDetailsController = Get.find();
      customerDetailsController.getUserAmounts();
      update();
      Get.back();
      CustomSnackBar.showCustomToast(
        title: Strings.addAmountHome,
        message: Strings.successUpdateAmount,
      );
    }
  }

  bool checkDate() {
    return dateTime.isNotEmpty;
  }

  List<DateTime?> dateTime = [];

  String selectedDate = '';
  bool? isSelectedDate = true;

  void changeDateTime(List<DateTime?> dates) {
    if (dates.isNotEmpty) {
      isSelectedDate = true;
      dateTime = dates;
      selectedDate = dateTime[0].toString().split(" ")[0];
      date.text = selectedDate;
    } else {
      isSelectedDate = false;
    }
    update();
  }

  bool checkSelectedDate() {
    if (dateTime.isEmpty && isSelectedDate != null) {
      isSelectedDate = false;
      update();
      return false;
    }
    isSelectedDate = true;
    update();
    return true;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    name = TextEditingController();
    amount = TextEditingController();
    date = TextEditingController();
    note = TextEditingController();
    checkUpdate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    amount.dispose();
    date.dispose();
    note.dispose();
    formKey.currentState?.dispose();
  }
}
