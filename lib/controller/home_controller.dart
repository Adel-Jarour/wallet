import 'package:customer_menu/data/local/db_controller/db_helper.dart';
import 'package:customer_menu/data/models/input_output_model.dart';
import 'package:customer_menu/data/models/user_model.dart';
import 'package:customer_menu/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<UserModel> users = [];

  var searchText = '';
  String? nameError;

  List<UserModel> filteredUsers = [];

  void setSearchText(String text) {
    searchText = text;
    getFilterUser();
    update();
  }

  getFilterUser() {
    filteredUsers = [];
    update();
    if (name.text.isNotEmpty && name.text != '') {
      for (var i in users) {
        if (i.name!.toLowerCase().startsWith(searchText)) {
          filteredUsers.add(i);
        }
      }
      if (filteredUsers.isEmpty) {
        nameError = 'لا يوجد شخص بهذا الإسم';
      } else {
        filteredUsers = filteredUsers.take(5).toList();
        nameError = null;
      }
    } else {
      nameError = 'الرجاء كتابة إسم';
    }
  }

  late UserModel? selectedUser;

  void setSelectedUser(UserModel user) {
    selectedUser = user;
    filteredUsers = [];
    name.clear();
    update();
    Get.toNamed(Routes.customerDetails, arguments: [selectedUser]);
  }

  late TextEditingController name;

  Future getUser() async {
    users = [];
    update();
    final res = await DatabaseHelper().getAllUsers();
    for (var i in res ?? []) {
      users.add(UserModel.fromMap(i));
    }
    update();
  }

  double totalInput = 0;
  double totalOutput = 0;
  double total = 0;
  String totalString = '';
  bool loading = false;

  List<InputOutputModel> allInputOutput = [];

  Future getTotal() async {
    totalInput = 0;
    totalOutput = 0;
    totalString = '';
    allInputOutput = [];
    loading = true;
    update();

    final res = await DatabaseHelper().getAllInputOutputAmounts();

    for (var i in res ?? []) {
      InputOutputModel inputOutputModel = InputOutputModel.fromMap(i);
      print(inputOutputModel);
      allInputOutput.add(inputOutputModel);
      if (inputOutputModel.input != null)
      totalInput += int.parse(inputOutputModel.input!);
      if (inputOutputModel.output != null)
      totalOutput += int.parse(inputOutputModel.output!);
    }
    total = totalInput - totalOutput;
    totalString = '${total.abs().toStringAsFixed(2)}';
    loading = false;
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    name = TextEditingController();
    await getUser();
    await getTotal();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
  }
}
