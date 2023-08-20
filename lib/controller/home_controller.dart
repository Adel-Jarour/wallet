import 'package:customer_menu/data/local/db_controller/db_helper.dart';
import 'package:customer_menu/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<UserModel> users = [];
  bool loading = false;

  Future getUser() async {
    users = [];
    loading = true;
    update();
    final res = await DatabaseHelper().getAllUsers();
    for (var i in res ?? []) {
      users.add(UserModel.fromMap(i));
    }
    loading = false;
    update();
  }


  var searchText = '';
  var selectedUsername = '';

  List<UserModel> filteredUsers = [];

  void setSearchText(String text) {
    searchText = text;
    getFilterUser();
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

  List<UserModel> filterUsers = [];

  Future getFilterUser() async {
    filteredUsers = [];
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUser();
    name = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
  }
}
