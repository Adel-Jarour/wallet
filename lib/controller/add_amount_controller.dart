import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/home_controller.dart';
import 'package:customer_menu/data/local/db_controller/db_helper.dart';
import 'package:customer_menu/data/models/user_model.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  final HomeController homeController = Get.find();

  var searchText = '';
  var selectedUsername = '';

  List<UserModel> filteredUsers = [];

  void setSearchText(String text) {
    searchText = text;
    getUser();
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
    selectedUsername = user.name!;
    filteredUsers = [];
    name.text = user.name!;
    isSelectedUser = true;
    update();
  }

  List<UserModel> users = [];
  bool loading = false;

  Future getUser() async {
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
    }
  }

  late TextEditingController name;
  late TextEditingController amount;
  late TextEditingController date;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool checkName() {
    isSelectedUser = false;
    update();
    return selectedUsername != '';
  }

  bool checkData() {
    if (formKey.currentState!.validate() && checkName()) {
      return true;
    }
    return false;
  }

  saveDataToDB() async {
    if (incoming) {
      await DatabaseHelper().insertAmount(
        selectedUser?.id ?? 0,
        date.text,
        input: amount.text,
      );
    } else {
      await DatabaseHelper().insertAmount(
        selectedUser?.id ?? 0,
        date.text,
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
      Get.snackbar(
        "",
        "",
        icon: const Icon(Icons.verified, color: Colors.green),
        snackPosition: SnackPosition.TOP,
        titleText: CustomText(
          txt: Strings.addAmountHome,
          fontSize: 18.sp,
        ),
        messageText: CustomText(
          txt: Strings.successAddAmount,
          color: Colors.black,
          fontSize: 15.sp,
        ),
        padding: EdgeInsets.all(20.0.r),
        borderRadius: 27.0,
        backgroundColor: Colors.white60,
      );
      isSubmit = false;
      name.clear();
      amount.clear();
      date.clear();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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
