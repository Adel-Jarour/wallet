import 'package:customer_menu/constance/strings_const.dart';
import 'package:customer_menu/controller/customer_details_controller.dart';
import 'package:customer_menu/view/widgets/custem_text.dart';
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
                        ],
                        color: MaterialStateColor.resolveWith(
                            (states) => rowColor),
                      );
                    }).toList(),
                  ),
      ),
    );
  }
}
