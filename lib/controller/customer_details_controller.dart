import 'dart:async';

import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/data/local/db_controller/db_helper.dart';
import 'package:customer_menu/data/models/amount_model.dart';
import 'package:customer_menu/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerDetailsController extends GetxController {
  UserModel user = Get.arguments[0];

  List<AmountModel> userAmount = [];
  List<AmountModel> userInputs = [];
  List<AmountModel> userOutputs = [];
  List<AmountModel> reversedUserAmount = [];

  double sumInputs = 0;
  double sumOutputs = 0;
  double totalAmount = 0;
  String totalAmountString = '';

  bool loading = false;

  Future getUserAmounts() async {
    userAmount = [];
    userInputs = [];
    userOutputs = [];
    reversedUserAmount = [];
    totalAmount = 0;
    sumInputs = 0;
    sumOutputs = 0;
    totalAmountString = '';
    loading = true;
    update();

    final res = await DatabaseHelper().getAmountsForUser(user.id);
    for (var i in res ?? []) {
      userAmount.add(AmountModel.fromMap(i));
      AmountModel amountModel = AmountModel.fromMap(i);
      if (amountModel.input != null) {
        sumInputs += double.parse(amountModel.input!);
        userInputs.add(amountModel);
      } else if (amountModel.output != null) {
        sumOutputs += double.parse(amountModel.output!);
        userOutputs.add(amountModel);
      }
    }
    reversedUserAmount = List.from(userAmount.reversed);
    totalAmount = sumInputs - sumOutputs;
    totalAmountString = '${totalAmount.abs().toStringAsFixed(2)}';
    loading = false;
    update();
  }

  bool isDeleted = false;

  Future<void> deleteAmount(int id) async {

    isDeleted = true;
    update();

    final res = await DatabaseHelper().deleteAmount(id, user.id);

    isDeleted = false;
    getUserAmounts();
    update();

    if (res != null) {
      Get.back();
    }

  }

  String checkType({required String? input}) {
    if (input != null) {
      return Strings.incomeButton;
    }
    return Strings.outcomeButton;
  }

  bool endElements = false;

  int numOfElements() {
    return (reversedUserAmount.length <= length)
        ? reversedUserAmount.length
        : length;
  }

  int length = 10;

  void increaseLength(BuildContext context) {
    if (reversedUserAmount.length > length) {
      length += 10;
    }
    scrollToEnd(context);
    if (reversedUserAmount.length <= length) {
      endElements = true;
    } else {
      endElements = false;
    }
    update();
  }

  final ScrollController scrollController = ScrollController();

  void scrollToEnd(BuildContext context) {
    Timer(Duration(milliseconds: 10), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  List<DateTime?> fromDates = [];

  String fromDate = '';

  void changeFromDateTime(List<DateTime?>? dates) {
    if (dates != null) {
      if (dates.isNotEmpty) {
        fromDates = dates;
        fromDate = fromDates[0].toString().split(" ")[0];
      }
    } else {
      fromDate = '';
      filterError = '';
    }
    changeFilters();
    update();
  }

  List<DateTime?> todDates = [];

  String toDate = '';

  void changeToDateTime(List<DateTime?>? dates) {
    if (dates != null) {
      if (dates.isNotEmpty) {
        todDates = dates;
        toDate = todDates[0].toString().split(" ")[0];
      }
    } else {
      toDate = '';
      filterError = '';
    }
    changeFilters();
    update();
  }

  List<AmountModel> userAmountFilter = [];
  String filterError = '';

  void changeFilters() {
    userAmountFilter = [];

    if (fromDate != '' && toDate != '') {
      filterFromAndTo();
    } else if (fromDate != '') {
      filterFromDate();
    } else if (toDate != '') {
      filterToDate();
    }
  }

  void filterFromAndTo() {
    for (var i in userAmount) {
      DateTime storedDate = dateFormat(i.date!);
      if (!storedDate.isBefore(fromDates[0]!) &&
          !storedDate.isAfter(todDates[0]!)) {
        userAmountFilter.add(i);
      }
    }
    if (userAmountFilter.isEmpty) {
      filterError = 'لا يوجد عمليات من تاريخ  $fromDate إلى تاريخ  $toDate';
    } else {
      filterError = '';
      length = 10;
    }
  }

  void filterFromDate() {
    for (var i in userAmount) {
      DateTime storedDate = dateFormat(i.date!);
      if (!storedDate.isBefore(fromDates[0]!)) {
        userAmountFilter.add(i);
      }
    }
    if (userAmountFilter.isEmpty) {
      filterError = 'لا يوجد عمليات من تاريخ  $fromDate';
    } else {
      filterError = '';
      length = 10;
    }
  }

  void filterToDate() {
    for (var i in userAmount) {
      DateTime storedDate = dateFormat(i.date!);
      if (!storedDate.isAfter(todDates[0]!)) {
        userAmountFilter.add(i);
      }
    }
    if (userAmountFilter.isEmpty) {
      filterError = 'لا يوجد عمليات إلى تاريخ  $toDate';
    } else {
      filterError = '';
      length = 10;
    }
  }

  DateTime dateFormat(String date) {
    List<String> dateParts = date.split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    return DateTime(year, month, day);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUserAmounts();
  }
}
