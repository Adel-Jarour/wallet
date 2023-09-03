import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/data/models/user_model.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FindUsersWidget extends StatelessWidget {
  const FindUsersWidget({
    Key? key,
    required this.onTap,
    required this.filterUsers,
    required this.checkIsSelectedUser,
  }) : super(key: key);

  final Function onTap;
  final List<UserModel> filterUsers;
  final bool checkIsSelectedUser;

  @override
  Widget build(BuildContext context) {
    return filterUsers.isEmpty
        ? const SizedBox()
        : Container(
            width: double.infinity,
            height: 300.h,
            padding: EdgeInsetsDirectional.only(
              top: 20.h,
              bottom: 5.h,
              start: 15.w,
              end: 5.w,
            ),
            margin: EdgeInsetsDirectional.only(top: 10.h),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: checkIsSelectedUser ? Colors.transparent : Colors.red,
                style:
                    checkIsSelectedUser ? BorderStyle.none : BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                CustomText(
                  txt: Strings.pleaseChooseAmount,
                  fontSize: 18.sp,
                  color: checkIsSelectedUser ? Colors.black : Colors.red,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                Divider(
                  color: checkIsSelectedUser ? Colors.black : Colors.red,
                  thickness: 1,
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: filterUsers.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          onTap(index);
                        },
                        child: Container(
                          padding:
                              EdgeInsetsDirectional.symmetric(vertical: 10.h),
                          alignment: Alignment.center,
                          child: CustomText(
                            txt: filterUsers[index].name,
                            fontSize: 20.sp,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 5.h,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
