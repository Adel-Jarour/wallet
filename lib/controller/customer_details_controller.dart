import 'package:customer_menu/data/local/db_controller/db_helper.dart';
import 'package:customer_menu/data/models/amount_model.dart';
import 'package:customer_menu/data/models/user_model.dart';
import 'package:get/get.dart';

class CustomerDetailsController extends GetxController {
  UserModel user = Get.arguments[0];

  // List<AmountModel> userAmount = [];
  List<AmountModel> userInputs = [];
  List<AmountModel> userOutputs = [];

  double sumInputs = 0;
  double sumOutputs = 0;
  double totalAmount = 0;

  bool loading = false;

  Future getUserAmounts() async {

    // userAmount = [];
    userInputs = [];
    userOutputs = [];
    loading = true;
    update();

    final res = await DatabaseHelper().getAmountsForUser(user.id);
    for (var i in res ?? []) {
      // userAmount.add(AmountModel.fromMap(i));
      AmountModel amountModel = AmountModel.fromMap(i);
      if (amountModel.input != null) {
        sumInputs += double.parse(amountModel.input!);
        userInputs.add(amountModel);
      } else if (amountModel.output != null) {
        sumOutputs += double.parse(amountModel.output!);
        userOutputs.add(amountModel);
      }
    }
    totalAmount = sumInputs - sumOutputs;
    loading = false;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserAmounts();
  }
}
