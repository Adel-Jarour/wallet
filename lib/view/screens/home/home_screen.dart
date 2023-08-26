import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/home_controller.dart';
import 'package:customer_menu/view/screens/customer_detail/widget/row_strings_widget.dart';
import 'package:customer_menu/view/screens/home/widget/home_text_field_widget.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:customer_menu/view/widgets/find_users_widget.dart';
import 'package:flutter/cupertino.dart';
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
                HomeTextFieldWidget(),
                SizedBox(
                  height: 60.h,
                ),
                controller.loading
                    ? CupertinoActivityIndicator()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RowStringsWidget(
                            text1: Strings.sumInputsDetail,
                            text2: "${controller.totalInput}",
                            colorText2: Colors.green,
                          ),
                          RowStringsWidget(
                            text1: Strings.sumOutputsDetail,
                            text2: "${controller.totalOutput}",
                            colorText2: Colors.redAccent,
                          ),
                          RowStringsWidget(
                            text1: Strings.totalAmount,
                            text2: controller.totalString,
                            colorText2: (controller.total == 0)
                                ? Colors.black
                                : (controller.total < 0)
                                    ? Colors.red
                                    : Colors.green,
                            endLine: true,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
