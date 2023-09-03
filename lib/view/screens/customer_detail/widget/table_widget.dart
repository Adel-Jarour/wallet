import 'package:customer_menu/constance/color_const.dart';
import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/customer_details_controller.dart';
import 'package:customer_menu/routing/routes.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
import 'package:customer_menu/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDetailsController>(
      builder: (controller) => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: (controller.filterError != '')
            ? CustomText(
                txt: controller.filterError,
                textAlign: TextAlign.center,
                height: 1.5,
              )
            : controller.userAmount.isEmpty
                ? CustomText(
                    txt: "${Strings.nothings} عمليات",
                    fontSize: 25.sp,
                    textAlign: TextAlign.center,
                  )
                : DataTable(
                    headingRowColor: MaterialStateProperty.all(
                      Colors.grey.shade300,
                    ),
                    border: TableBorder.all(
                      style: BorderStyle.none,
                    ),
                    headingRowHeight: 60.h,
                    horizontalMargin: 10.w,
                    columnSpacing: 15.w,
                    showCheckboxColumn: false,
                    columns: [
                      DataColumn(
                        label: CustomText(txt: Strings.type),
                      ),
                      DataColumn(
                        label: CustomText(txt: Strings.amountTextField),
                      ),
                      DataColumn(
                        label: CustomText(txt: Strings.dateTextField),
                      ),
                      DataColumn(
                        label: CustomText(txt: ''),
                      ),
                    ],
                    rows: (controller.userAmountFilter.isNotEmpty
                            ? controller.userAmountFilter
                            : controller.reversedUserAmount)
                        .take(controller.numOfElements())
                        .map((operation) {
                      Color rowColor = operation.input != null
                          ? Colors.greenAccent
                          : Colors.amber.shade200;

                      return DataRow(
                        onLongPress: () {
                          Get.defaultDialog(
                            title: Strings.notesTextField,
                            titleStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                            content: CustomText(
                              txt: (operation.note != null &&
                                      operation.note!.isNotEmpty)
                                  ? operation.note
                                  : Strings.nothings,
                              color: Colors.black,
                              fontSize: 17.sp,
                              letterSpacing: 1,
                              height: 1.4,
                              softWrap: true,
                            ),
                          );
                        },
                        cells: [
                          DataCell(
                            CustomText(
                              txt: controller.checkType(input: operation.input),
                            ),
                          ),
                          DataCell(
                            CustomText(
                                txt: operation.input ?? operation.output),
                          ),
                          DataCell(
                            CustomText(txt: operation.date.toString()),
                          ),
                          DataCell(
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.addAmount, arguments: [operation]);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey.shade600,
                                    size: 22.r,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: Strings.areYouSureDelete,
                                      content: Row(
                                        children: [
                                          Expanded(
                                            child: CustomButton(
                                              txt: Strings.yesButton,
                                              onTap: () async {
                                                await controller
                                                    .deleteAmount(operation.id);
                                              },
                                              enabled: controller.isDeleted,
                                              colorButton: Colors.transparent,
                                              colorTxt: Colors.redAccent,
                                              border: Border.all(
                                                color: Colors.redAccent,
                                              ),
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Expanded(
                                            child: CustomButton(
                                              txt: Strings.noButton,
                                              onTap: () {
                                                Get.back();
                                              },
                                              colorButton: Colors.transparent,
                                              colorTxt: Colors.blueAccent,
                                              border: Border.all(
                                                color: Colors.blueAccent,
                                              ),
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.grey.shade600,
                                    size: 22.r,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        color: MaterialStateColor.resolveWith(
                          (states) => rowColor,
                        ),
                      );
                    }).toList(),
                  ),
      ),
    );
  }
}
