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

  bool loading = false;

  Future getUserAmounts() async {
    userAmount = [];
    userInputs = [];
    userOutputs = [];
    reversedUserAmount = [];
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
    loading = false;
    update();
  }

  String checkType({required String? input}) {
    if (input != null) {
      return Strings.incomeButton;
    }
    return Strings.outcomeButton;
  }

  int numOfElements() {
    return (reversedUserAmount.length <= length)
        ? reversedUserAmount.length
        : length;
  }

  int length = 10;

  void increaseLength(BuildContext context) {
    if (reversedUserAmount.length > length) {
      length += 10;
      update();
    }
    scrollToEnd(context);
  }

  final ScrollController scrollController = ScrollController();

  void scrollToEnd(BuildContext context) {
    double position = -(reversedUserAmount.length - length) *
        (MediaQuery.of(context).size.height);

    scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  List<DateTime?> fromDates = [];

  String fromDate = '';

  void changeFromDateTime(List<DateTime?> dates) {
    if (dates.isNotEmpty) {
      fromDates = dates;
      fromDate = fromDates[0].toString().split(" ")[0];
      print(fromDates[0].toString().split(" ")[0]);
    } else {}
    update();
  }

  List<DateTime?> todDates = [];

  String toDate = '';

  void changeToDateTime(List<DateTime?> dates) {
    if (dates.isNotEmpty) {
      todDates = dates;
      toDate = todDates[0].toString().split(" ")[0];
      print(todDates[0].toString().split(" ")[0]);
    } else {}
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUserAmounts();
  }
}
