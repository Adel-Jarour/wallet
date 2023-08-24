import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/customer_details_controller.dart';
import 'package:customer_menu/view/screens/customer_detail/widget/date_detail_widget.dart';
import 'package:customer_menu/view/screens/customer_detail/widget/floating_button_widget.dart';
import 'package:customer_menu/view/screens/customer_detail/widget/info_widget.dart';
import 'package:customer_menu/view/screens/customer_detail/widget/table_widget.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetailScreen extends StatelessWidget {
  CustomerDetailScreen({Key? key}) : super(key: key);

  final CustomerDetailsController controller =
      Get.put(CustomerDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButtonWidget(),
      appBar: AppBar(
        title: CustomText(
          txt: Strings.customerDetailHome,
          color: Colors.white,
          fontSize: 20.sp,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: Strings.notesTextField,
                titleStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      txt: (controller.user.note != null &&
                              controller.user.note!.isNotEmpty)
                          ? controller.user.note!
                          : Strings.nothings,
                      color: Colors.black,
                      fontSize: 17.sp,
                      letterSpacing: 1,
                      height: 1.4,
                      softWrap: true,
                    ),
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.insert_drive_file_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: GetBuilder<CustomerDetailsController>(
        builder: (controller) => SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoWidget(),
              DateDetailWidget(),
              TableWidget(),
            ],
          ),
        ),
      ),
    );
  }
}