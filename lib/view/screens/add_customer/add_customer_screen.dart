import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/add_customer_controller.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:customer_menu/view/widgets/custom_button.dart';
import 'package:customer_menu/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          txt: Strings.addCustomerHome,
          color: Colors.white,
          fontSize: 20.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 20.w,
            vertical: 40.h,
          ),
          child: GetBuilder<AddCustomerController>(
            builder: (controller) => Column(
              children: [
                Form(
                  key: controller.formKey,
                  child: CustomTextFormField(
                    controller: controller.name,
                    hintTxt: Strings.nameTextField,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                CustomTextFormField(
                  controller: controller.note,
                  hintTxt: Strings.notesTextField,
                  minLines: 5,
                  maxLines: 5,
                ),
                SizedBox(
                  height: 50.h,
                ),
                CustomButton(
                  txt: Strings.addButton,
                  onTap: () {
                    controller.performAdd();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
