import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vargikaran_web_app/layout/adaptive.dart';
import 'package:vargikaran_web_app/vargikarn_utiles.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({Key? key}) : super(key: key);

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  final fileNoController = TextEditingController();
  final recordDateController = TextEditingController();
  final subjectController = TextEditingController();
  final applicationNameController = TextEditingController();
  final orderNoController = TextEditingController();
  final remarksController = TextEditingController();
  final noOfPagesController = TextEditingController();
  final startDateInputController = TextEditingController();
  final endDateInputController = TextEditingController();

  var boxItemList = [1, 2, 3, 4, 5, 6].obs;
  RxInt boxDropdownValue = 1.obs;

  var cupBoardItemList = ['Name1', 'name2', 'name3',].obs;
  RxString cupBoardItemNameDropdownValue = 'Name1'.obs;

  var rackItemList = ['Name1', 'name2', 'name3','name4',].obs;
  RxString rackItemNameDropdownValue = 'Name1'.obs;

  var selectedItemNameList =
      ['Name1', 'name2', 'name3', 'name4', 'name5', 'name6'].obs;
  RxString selectedItemNameDropdownValue = 'Name1'.obs;


  var selectedItemClassNameList = ['Name1', 'name2', 'name3', 'name4'].obs;
  RxString selectedItemClassNameDropdownValue = 'Name1'.obs;

  RxString selectedItemDepartmentNameDropdownValue = 'Name1'.obs;
  RxInt selectedItemDepartmentDropdownValue = 1.obs;


  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final isSmallDesktop = isDisplaySmallDesktop(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10, right: 8, left: 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText('Add New File',
                style: TextStyle(fontSize: 22, color: Colors.grey.shade800)),
            Card(
              elevation: 1,
              margin: const EdgeInsets.only(top: 18, bottom: 12),
              child: isDesktop
                  ? buildDesktopDepartmentCardView(isSmallDesktop)
                  : Container(
                      padding: const EdgeInsets.only(left: 9),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.settings,
                                    size: 17,
                                  )),
                              const Text('DEPARTMENT DETAILS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              buildRowText('Fn. No'),
                              Flexible(
                                child: Utils().textFormFiledView(
                                  controller: fileNoController,
                                  hintText: 'Enter F.N No',
                                  autofillHints: [AutofillHints.creditCardName],
                                  textInputType: TextInputType.number,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              buildRowText('Select Department*'),
                              Obx(
                                () => Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  child: buildSelectDepartNameDropdownView(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              buildRowText('Select Branch*'),
                              Obx(
                                () => Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  child: selectBranchDropDownView(),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
            ),
            Card(
              elevation: 1,
              margin: const EdgeInsets.only(top: 18, bottom: 12),
              child: isSmallDesktop
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          buildDocumentDetailsCard(),
                          buildDocumentDetailsLocationCard()
                        ],
                      ),
                    )
                  : isDesktop
                      ? buildDesktopDocumentCardView()
                      : Container(
                          padding: const EdgeInsets.only(left: 9),
                          child: Column(
                            children: [
                              buildDocumentDetailsCard(),
                              buildDocumentDetailsLocationCard()
                            ],
                          ),
                        ),
            ),
            Card(
              elevation: 1,
              margin: const EdgeInsets.only(top: 18, bottom: 12),
              child: isDesktop
                  ? buildDesktopDepartmentLastCardView(isSmallDesktop)
                  : Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.only(
                          left: 9, top: 8, bottom: 20, right: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.settings,
                                    size: 17,
                                  )),
                              const Text('DEPARTMENT DETAILS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              buildRowText('cupboard'),
                              Obx(
                                () => buildCupBoardView(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              buildRowText('Rack*'),
                              Obx(
                                () => buildRackView(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              buildRowText('Box*'),
                              Obx(
                                () => Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  child: boxDropDownList(),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
            ),
            Utils().buildButtonView(),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> selectBranchDropDownView() {
    return DropdownButton<String>(
      isDense: true,
      elevation: 0,
      underline: Container(),
      dropdownColor: Colors.white,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: selectedItemNameList.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text('Select Branch $items',
              style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        selectedItemNameDropdownValue.value = newValue!;
      },
      value: selectedItemNameDropdownValue.value,
    );
  }

  DropdownButton<int> buildSelectDepartNameDropdownView() {
    return DropdownButton<int>(
      isDense: true,
      elevation: 0,
      underline: Container(),
      dropdownColor: Colors.white,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: boxItemList.map((int items) {
        return DropdownMenuItem(
          value: items,
          child: Text('Select Department $items',
              style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: (int? newValue) {
        selectedItemDepartmentDropdownValue.value = newValue!;
      },
      value: selectedItemDepartmentDropdownValue.value,
    );
  }

  Container buildCupBoardView() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: DropdownButton<String>(
        isDense: true,
        elevation: 0,
        dropdownColor: Colors.white,
        underline: Container(),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: cupBoardItemList.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text('Select $items ',
                style: const TextStyle(fontSize: 14)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          cupBoardItemNameDropdownValue.value = newValue!;
        },
        value: cupBoardItemNameDropdownValue.value,
      ),
    );
  }

  Container buildRackView() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: DropdownButton<String>(
        isDense: true,
        elevation: 0,
        dropdownColor: Colors.white,
        underline: Container(),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: rackItemList.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text('Select $items ',
                style: const TextStyle(fontSize: 14)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          rackItemNameDropdownValue.value = newValue!;
        },
        value: rackItemNameDropdownValue.value,
      ),
    );
  }

  Widget buildDesktopDepartmentCardView(bool isSmallDesktop) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    size: 17,
                  )),
              const Text('DEPARTMENT DETAILS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          const Divider(thickness: 0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12, right: 10),
                  child: Row(
                    children: [
                      buildRowText('Fn. No.'),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Utils().textFormFiledView(
                            controller: fileNoController,
                            hintText: 'Enter F.N No',
                            autofillHints: [AutofillHints.creditCardName],
                            textInputType: TextInputType.number,
                            keyboardType: TextInputType.number,
                            validator: (value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    children: [
                      buildRowText('Select Department*'),
                      Obx(
                        () => Flexible(
                          child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: buildSelectDepartNameDropdownView()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              isSmallDesktop
                  ? Container()
                  : Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          children: [
                            buildRowText('Select Branch*'),
                            selectedBranchView(),
                          ],
                        ),
                      ),
                    )
            ],
          ),
          isSmallDesktop
              ? Container(
                  margin: const EdgeInsets.only(
                      left: 8, right: 8, top: 10, bottom: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildRowText('Select Branch'),
                      selectedBranchView(),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Obx selectedBranchView() {
    return Obx(
      () => Flexible(
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: selectBranchDropDownView(),
        ),
      ),
    );
  }

  Widget buildDesktopDepartmentLastCardView(bool isSmallDesktop) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 8, right: 8, left: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    size: 17,
                  )),
              const Text('DEPARTMENT DETAILS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  buildRowText('cupboard*'),
                  Obx(
                    () => buildCupBoardView(),
                  ),
                ],
              ),
              Row(
                children: [
                  buildRowText('Rack*'),
                  Obx(
                    () => buildRackView(),
                  ),
                ],
              ),
              isSmallDesktop
                  ? Container()
                  : Row(
                      children: [
                        buildRowText('Box*'),
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: boxDropDownList(),
                          ),
                        ),
                      ],
                    )
            ],
          ),
          isSmallDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildRowText('Box*'),
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: boxDropDownList(),
                      ),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }

  DropdownButton<int> boxDropDownList() {
    return DropdownButton<int>(
      isDense: true,
      elevation: 0,
      dropdownColor: Colors.white,
      underline: Container(),
      icon: const Icon(Icons.keyboard_arrow_down),
      items: boxItemList.map((int items) {
        return DropdownMenuItem(
          value: items,
          child:
              Text('Select Name $items', style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: (int? newValue) {
        boxDropdownValue.value = newValue!;
      },
      value: boxDropdownValue.value,
    );
  }

  Widget buildDesktopDocumentCardView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(flex: 2, child: buildDocumentDetailsCard()),
          Flexible(flex: 1, child: buildDocumentDetailsLocationCard())
        ],
      ),
    );
  }

  Card buildDocumentDetailsLocationCard() {
    return Card(
      child: Container(
        margin: const EdgeInsets.only(left: 12, top: 20, right: 12),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.settings,
                      size: 17,
                    )),
                const Text('LOCATION DETAILS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Row(
              children: [
                buildRowText('Select Class'),
                Obx(
                  () => Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      margin:
                          const EdgeInsets.only(left: 5, bottom: 6, right: 7),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: buildSelectClassNameDropDownValue(),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                buildRowText('Start Date'),
                Expanded(
                  child: GestureDetector(
                    child: Utils().textFormFiledView(
                      hintText: 'dd-mm-yy',
                      controller: startDateInputController,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.calendar_month),
                      autofillHints: [AutofillHints.creditCardName],
                      textInputType: TextInputType.number,
                      keyboardType: TextInputType.number,
                      validator: (value) {},
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            startDateInputController.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    onTap: () {
                      selectedDate.toLocal();
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                buildRowText('End Date'),
                Expanded(
                  child: GestureDetector(
                    child: Utils().textFormFiledView(
                      hintText: 'dd-mm-yy',
                      controller: endDateInputController,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.calendar_month),
                      autofillHints: [AutofillHints.creditCardName],
                      textInputType: TextInputType.number,
                      keyboardType: TextInputType.number,
                      validator: (value) {},
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            endDateInputController.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                buildRowText('No. of Pages'),
                Expanded(
                  child: Utils().textFormFiledView(
                    controller: noOfPagesController,
                    hintText: '',
                    autofillHints: [AutofillHints.creditCardName],
                    textInputType: TextInputType.number,
                    keyboardType: TextInputType.number,
                    validator: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> buildSelectClassNameDropDownValue() {
    return DropdownButton<String>(
      isDense: true,
      elevation: 0,
      dropdownColor: Colors.white,
      underline: Container(),
      icon: const Icon(Icons.keyboard_arrow_down),
      items: selectedItemClassNameList.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text('Select $items', style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        selectedItemDepartmentNameDropdownValue.value = newValue!;
      },
      value: selectedItemDepartmentNameDropdownValue.value,
    );
  }



  Widget buildDocumentDetailsCard() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    size: 17,
                  )),
              const Text('DOCUMENT DETAILS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          const Divider(thickness: 0.5),
          Row(
            children: [
              buildRowText('Record Date'),
              Expanded(
                child: Utils().textFormFiledView(
                  controller: recordDateController,
                  hintText: '',
                  autofillHints: [AutofillHints.creditCardName],
                  textInputType: TextInputType.number,
                  keyboardType: TextInputType.number,
                  validator: (value) {},
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRowText('Subject'),
              Expanded(
                child: Utils().textFormFiledView(
                  controller: subjectController,
                  hintText: '',
                  maxLine: 4,
                  minLines: 4,
                  isMaxLength: true,
                  maxLength: 400,
                  validator: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              buildRowText('Application Name'),
              Expanded(
                child: Utils().textFormFiledView(
                  controller: applicationNameController,
                  hintText: '',
                  isMaxLength: true,
                  maxLength: 100,
                  autofillHints: [AutofillHints.creditCardName],
                  textInputType: TextInputType.number,
                  keyboardType: TextInputType.number,
                  validator: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              buildRowText('Order No'),
              Expanded(
                child: Utils().textFormFiledView(
                  controller: orderNoController,
                  hintText: '',
                  isMaxLength: true,
                  maxLength: 100,
                  autofillHints: [AutofillHints.creditCardName],
                  textInputType: TextInputType.number,
                  keyboardType: TextInputType.number,
                  validator: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              buildRowText('Remarks'),
              Expanded(
                child: Utils().textFormFiledView(
                  controller: remarksController,
                  hintText: '',
                  isMaxLength: true,
                  maxLength: 100,
                  autofillHints: [AutofillHints.creditCardName],
                  textInputType: TextInputType.number,
                  keyboardType: TextInputType.number,
                  validator: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildRowText(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      width: 160,
      padding: const EdgeInsets.only(right: 10, top: 14, bottom: 8),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
