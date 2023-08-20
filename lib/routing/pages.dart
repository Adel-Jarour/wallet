import 'package:customer_menu/routing/routes.dart';
import 'package:customer_menu/view/screens/add_amount/add_amount_screen.dart';
import 'package:customer_menu/view/screens/add_customer/add_customer_screen.dart';
import 'package:customer_menu/view/screens/customer_detail/customer_detail_screen.dart';
import 'package:customer_menu/view/screens/home/home_screen.dart';
import 'package:get/get.dart';

abstract class AppPages {

  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.addCustomer,
      page: () => AddCustomerScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.customerDetails,
      page: () => CustomerDetailScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.addAmount,
      page: () => AddAmountScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}
