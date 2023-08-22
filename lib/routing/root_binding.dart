import 'package:customer_menu/controller/add_customer_controller.dart';
import 'package:customer_menu/controller/home_controller.dart';
import 'package:get/get.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<AddCustomerController>(AddCustomerController());
  }
}
