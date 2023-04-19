import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  var itemList = [1, 2, 3, 4, 5, 6].obs;
  var selectedItemNameList =
      ['misthi', 'miva', 'manavi', 'vartika', 'savi', 'sitara'].obs;
  RxString selectedItemNameDropdownValue = 'misthi'.obs;
  RxInt dropdownValue = 1.obs;

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
                              buildRowText('Select DepartMent'),
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
                                  child: DropdownButton<int>(
                                    isDense: true,
                                    elevation: 0,
                                    underline: Container(),
                                    dropdownColor: Colors.white,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: itemList.map((int items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text('$items Department',
                                            style:
                                                const TextStyle(fontSize: 14)),
                                      );
                                    }).toList(),
                                    onChanged: (int? newValue) {
                                      dropdownValue.value = newValue!;
                                    },
                                    value: dropdownValue.value,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              buildRowText('Select Branch'),
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
                                  child: DropdownButton<int>(
                                    isDense: true,
                                    elevation: 0,
                                    underline: Container(),
                                    dropdownColor: Colors.white,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: itemList.map((int items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text('$items Branch',
                                            style:
                                                const TextStyle(fontSize: 14)),
                                      );
                                    }).toList(),
                                    onChanged: (int? newValue) {
                                      dropdownValue.value = newValue!;
                                    },
                                    value: dropdownValue.value,
                                  ),
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
                          buildDocumentDetailsFirstCardView(),
                          buildDocumentDetalisSecondCard()
                        ],
                      ),
                    )
                  : isDesktop
                      ? buildDesktopDocumentCardView()
                      : Container(
                          padding: const EdgeInsets.only(left: 9),
                          child: Column(
                            children: [
                              buildDocumentDetailsFirstCardView(),
                              buildDocumentDetalisSecondCard()
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
                                () => buildCupBoardView(),
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

  Container buildCupBoardView() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: DropdownButton<int>(
        isDense: true,
        elevation: 0,
        dropdownColor: Colors.white,
        underline: Container(),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: itemList.map((int items) {
          return DropdownMenuItem(
            value: items,
            child:
                Text('$items Department', style: const TextStyle(fontSize: 14)),
          );
        }).toList(),
        onChanged: (int? newValue) {
          dropdownValue.value = newValue!;
        },
        value: dropdownValue.value,
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
                      buildRowText('Fn. No'),
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
                      buildRowText('Select DepartMent'),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: DropdownButton<int>(
                              isDense: true,
                              underline: Container(),
                              elevation: 0,
                              dropdownColor: Colors.white,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: itemList.map((int items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text('$items Department',
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14)),
                                );
                              }).toList(),
                              onChanged: (int? newValue) {
                                dropdownValue.value = newValue!;
                              },
                              value: dropdownValue.value,
                            ),
                          ),
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
                            buildRowText('Select Branch'),
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
          child: DropdownButton<int>(
            isDense: true,
            elevation: 0,
            underline: Container(),
            dropdownColor: Colors.white,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: itemList.map((int items) {
              return DropdownMenuItem(
                value: items,
                child: Text('$items Branch',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
            onChanged: (int? newValue) {
              dropdownValue.value = newValue!;
            },
            value: dropdownValue.value,
          ),
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
                  buildRowText('cupboard'),
                  Obx(
                    () => buildCupBoardView(),
                  ),
                ],
              ),
              Row(
                children: [
                  buildRowText('Rack*'),
                  Obx(
                    () => buildCupBoardView(),
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
      items: itemList.map((int items) {
        return DropdownMenuItem(
          value: items,
          child: Text('$items Branch', style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: (int? newValue) {
        dropdownValue.value = newValue!;
      },
      value: dropdownValue.value,
    );
  }

  Widget buildDesktopDocumentCardView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(flex: 2, child: buildDocumentDetailsFirstCardView()),
            Flexible(flex: 1, child: buildDocumentDetalisSecondCard())
          ],
        ),
      ),
    );
  }

  Card buildDocumentDetalisSecondCard() {
    return Card(
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
                () => Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 5, bottom: 4),
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
                    items: selectedItemNameList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text('$items',
                            style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedItemNameDropdownValue.value = newValue!;
                    },
                    value: selectedItemNameDropdownValue.value,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              buildRowText('Start Date'),
              SizedBox(
                height: 70,
                width: 200,
                child: GestureDetector(
                  child: Utils().textFormFiledView(
                    hintText: 'dd-mm-yy',
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_month),
                    autofillHints: [AutofillHints.creditCardName],
                    textInputType: TextInputType.number,
                    keyboardType: TextInputType.number,
                    validator: (value) {},
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
              buildRowText('End Date'),
              SizedBox(
                height: 70,
                width: 200,
                child: GestureDetector(
                  child: Utils().textFormFiledView(
                    hintText: 'dd-mm-yy',
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_month),
                    autofillHints: [AutofillHints.creditCardName],
                    textInputType: TextInputType.number,
                    keyboardType: TextInputType.number,
                    validator: (value) {},
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
              SizedBox(
                height: 70,
                width: 200,
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
    );
  }

  Widget buildDocumentDetailsFirstCardView() {
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
            children: [
              buildRowText('Subject'),
              Expanded(
                child: Utils().textFormFiledView(
                  controller: subjectController,
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
      alignment: Alignment.centerRight,
      width: 160,
      padding: const EdgeInsets.only(right: 10, top: 14, bottom: 8),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
