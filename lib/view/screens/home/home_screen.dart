import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/home_controller.dart';
import 'package:customer_menu/routing/routes.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:customer_menu/view/widgets/custom_text_form_field.dart';
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
                  checkIsSelectedUser: controller.checkIsSelectedUser(),
                ),
                CustomTextFormField(
                  controller: controller.name,
                  hintTxt: Strings.nameTextField,
                  onChanged: (text) {
                    controller.setSearchText(text);
                    Get.toNamed(Routes.customerDetails,
                        arguments: [controller.selectedUser]);
                  },
                ),
                SizedBox(
                  height: 40.h,
                ),
                ...controller.users
                    .map(
                      (e) => Padding(
                        padding: EdgeInsetsDirectional.only(bottom: 30.h),
                        child: ListTile(
                          contentPadding: EdgeInsetsDirectional.zero,
                          title: CustomText(
                            txt: e.name,
                            fontSize: 20.sp,
                          ),
                          subtitle: CustomText(
                            txt: e.note,
                            fontSize: 17.sp,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            Get.toNamed(Routes.customerDetails,
                                arguments: [e]);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
