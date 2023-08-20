import 'package:customer_menu/routing/pages.dart';
import 'package:customer_menu/routing/root_binding.dart';
import 'package:customer_menu/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'constance/color_const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => GetMaterialApp(
        title: 'Customers menu',
        debugShowCheckedModeBanner: false,
        initialBinding: RootBinding(),
        initialRoute: Routes.home,
        getPages: AppPages.pages,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: ColorConst.primaryColor,
          ),
        ),
        locale: const Locale('ar'),
      ),
    );
  }
}
