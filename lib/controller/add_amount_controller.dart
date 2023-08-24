import 'package:customer_menu/components/custom_snackbar.dart';
import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/data/local/db_controller/db_helper.dart';
import 'package:customer_menu/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAmountController extends GetxController {
  bool incoming = true;
  bool outComing = false;

  int currentIndex = 0;

  void changeComingIndex(int index) {
    if (currentIndex != index) {
      incoming = !incoming;
      outComing = !outComing;
      currentIndex = index;
      update();
    }
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
        input: amount.text,
      );
    } else {
      await DatabaseHelper().insertAmount(
        selectedUser?.id ?? 0,
        selectedDate,
        output: amount.text,
      );
    }
  }

  bool isSubmit = false;

  void performSave() async {
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
    print(dateTime);
    name = TextEditingController();
    amount = TextEditingController();
    date = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    amount.dispose();
    date.dispose();
  }
}
