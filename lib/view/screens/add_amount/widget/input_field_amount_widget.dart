import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/add_amount_controller.dart';
import 'package:customer_menu/view/screens/add_amount/widget/date_add_amount_widget.dart';
import 'package:customer_menu/view/widgets/custom_text_form_field.dart';
import 'package:customer_menu/view/widgets/find_users_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InputFieldAmountWidget extends StatelessWidget {
  InputFieldAmountWidget({
    super.key,
  });

  final AddAmountController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: controller.formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: controller.name,
                hintTxt: Strings.nameTextField,
                onChanged: (text) {
                  controller.setSearchText(text);
                },
                errorText: controller.nameError,
              ),
              FindUsersWidget(
                onTap: (index) {
                  controller
                      .setSelectedUser(controller.filteredUsers[index]);
                },
                filterUsers: controller.filteredUsers,
                checkIsSelectedUser: controller.checkIsSelectedUser(),
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomTextFormField(
                controller: controller.amount,
                hintTxt: Strings.amountTextField,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 40.h,
              ),
              DateAddAmountWidget(),
            ],
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
      ],
    );
  }
}
