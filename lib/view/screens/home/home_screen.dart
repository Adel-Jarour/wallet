import 'package:customer_menu/constance/color_const.dart';
import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/home_controller.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:customer_menu/view/widgets/find_users_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widget/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: CustomText(
          txt: Strings.appBarTitleHome,
          color: Colors.white,
          fontSize: 20.sp,
        ),
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                vertical: 20.h, horizontal: 20.w),
            child: Column(
              children: [
                FindUsersWidget(
                  onTap: (index) {
                    controller.setSelectedUser(controller.filteredUsers[index]);
                  },
                  filterUsers: controller.filteredUsers,
                  checkIsSelectedUser: true,
                ),
                TextFormField(
                  controller: controller.name,
                  onChanged: (text) {
                    controller.setSearchText(text);
                  },
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  onTapOutside: (x) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  style: TextStyle(
                    fontFamily: "IBMPlexSansArabic",
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: Strings.searchCustomerTextField,
                    hintStyle: TextStyle(
                      fontFamily: "IBMPlexSansArabic",
                      color: Colors.grey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: ColorConst.primaryColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsetsDirectional.only(
                      end: 8.w,
                      top: 16.h,
                      bottom: 16.h,
                      start: 8.w,
                    ),
                    errorText: controller.nameError,
                    errorStyle: TextStyle(
                      fontFamily: "IBMPlexSansArabic",
                      color: Colors.red,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
