import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:vargikaran_web_app/layout/adaptive.dart';
import 'package:vargikaran_web_app/loading_controller.dart';
import 'package:vargikaran_web_app/model/files_model.dart';
import 'package:vargikaran_web_app/services/database.dart';
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

  final LoadingController loadingController = Get.put(LoadingController());

  var boxItemList = ['Name1', 'name2', 'name3','Select Name'].obs;
  RxString boxDropdownValue = 'Select Name'.obs;

  var cupBoardItemList = ['Name1', 'name2', 'name3','Select Name'].obs;
  RxString cupBoardItemNameDropdownValue = 'Select Name'.obs;

  var rackItemList = ['Name1', 'name2', 'name3','name4','Select Name'].obs;
  RxString rackItemNameDropdownValue = 'Select Name'.obs;

  var selectedItemNameList =
      ['Name1', 'name2', 'name3', 'name4', 'name5', 'Select Branch'].obs;
  RxString selectedItemNameDropdownValue = 'Select Branch'.obs;

  var selectedItemClassNameList = ['Name1', 'name2', 'name3', 'name4','Select Name'].obs;
  RxString selectedItemClassNameDropdownValue = 'Select Name'.obs;

  var departmentNameItemNameList = ['Name1', 'name2', 'name3', 'name4', 'Select Department'].obs;
  RxString selectedItemDepartmentNameDropdownValue = 'Select Department'.obs;

  RxInt selectedItemDepartmentDropdownValue = 1.obs;


  DateTime selectedDate = DateTime.now();
   double progressValue = 20;

  int startDate = 0 ;
  int endDate = 0 ;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final isSmallDesktop = isDisplaySmallDesktop(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10, right: 8, left: 8),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(loadingController.isLoading.isTrue)...[
                LinearProgressIndicator(
                  backgroundColor: Colors.cyanAccent,
                  valueColor:  const AlwaysStoppedAnimation<Color>(Colors.red),
                  value: progressValue,
                ),
              ],
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
                                buildRowText(title: 'Fn. No',width: 160),
                                Flexible(
                                  child: Utils().textFormFiledView(
                                    controller: fileNoController,
                                    hintText: 'Enter F.N No',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return onTextEmptyMsg();
                                      }else if(value.isAlphabetOnly){
                                        return 'Please enter numeric value';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                buildRowText(title: 'Select Department*',width: 160),
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
                                buildRowText(title: 'Select Branch*',width: 160),
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
                                buildRowText(title: 'Cupboard'),
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
                                buildRowText(title: 'Rack*'),
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
                                buildRowText(title: 'Box*'),
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
              Row(
                children: [
                  Utils().buildButtonView(onTap:()
                  async {
                    loadingController.checkLoginStatus(
                        isAllDetailsFilled: _formKey.currentState!.validate(),
                        context: context);
                    if (_formKey.currentState!.validate()) {
                    final FileModel fileData = FileModel(
                      id: userID(),
                      applicationName: applicationNameController.text,
                      boxName: boxDropdownValue.value,
                      branch: selectedItemNameDropdownValue.value,
                      classes: selectedItemClassNameDropdownValue.value,
                      cupBoardName: cupBoardItemNameDropdownValue.value,
                      department: selectedItemDepartmentNameDropdownValue.value,
                      endDate:endDate,
                      fnNo: fileNoController.text,
                      noOfPages: noOfPagesController.text,
                      orderNo: orderNoController.text,
                      rackName: rackItemNameDropdownValue.value,
                      recordDate: recordDateController.text,
                      remarks: remarksController.text,
                      startDate: startDate,
                      subject: subjectController.text,
                    );

                    await Database().addFilesData(fileData, context);
                    }
                    loadingController.isLoading.value = false;

                    clearTextFiledData();

                  },title: 'Submit'),
                  Utils().buildButtonView(onTap:(){},title: 'Cancel'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  String userID() {
    return const Uuid().v4();
  }

  DropdownButton<String> selectBranchDropDownView() {
    return DropdownButton<String>(
      isDense: true,
      underline: Container(),
      value: selectedItemNameDropdownValue.value,
      elevation: 0,
      dropdownColor: Colors.white,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: selectedItemNameList.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items,
              style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        selectedItemNameDropdownValue.value = newValue!;
      },

    );
  }

  DropdownButton<String> buildSelectDepartNameDropdownView() {
    return DropdownButton<String>(
      isDense: true,
      elevation: 0,
      dropdownColor: Colors.white,
      underline: Container(),
      value: selectedItemDepartmentNameDropdownValue.value,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: departmentNameItemNameList.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text('$items ',
              style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        selectedItemDepartmentNameDropdownValue.value = newValue!;
      },
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
        value: cupBoardItemNameDropdownValue.value,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: cupBoardItemList.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text('$items ',
                style: const TextStyle(fontSize: 14)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          cupBoardItemNameDropdownValue.value = newValue!;
        },

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
        value: rackItemNameDropdownValue.value,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: rackItemList.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text('$items ',
                style: const TextStyle(fontSize: 14)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          rackItemNameDropdownValue.value = newValue!;
        },

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
                      buildRowText(title: 'Fn. No.',width: 160),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Utils().textFormFiledView(
                            controller: fileNoController,
                            hintText: 'Enter F.N No',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return onTextEmptyMsg();
                              }else if(value.isAlphabetOnly){
                                return 'Please enter only numeric text';
                              }
                              return null;
                            },
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
                      buildRowText(title: 'Select Department*',width: 160),
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
                            buildRowText(title: 'Select Branch*',width: 160),
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
                      buildRowText(title: 'Select Branch',width: 160),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  buildRowText(title: 'Cupboard*'),
                  Obx(
                    () => buildCupBoardView(),
                  ),
                ],
              ),
              Row(
                children: [
                  buildRowText(title: 'Rack*'),
                  Obx(
                    () => buildRackView(),
                  ),
                ],
              ),
              isSmallDesktop
                  ? Container()
                  : Row(
                      children: [
                        buildRowText(title: 'Box*'),
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
                  children: [
                    buildRowText(title: 'Box*'),
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

  DropdownButton<String> boxDropDownList() {
    return DropdownButton<String>(
      isDense: true,
      elevation: 0,
      dropdownColor: Colors.white,
      underline: Container(),
      value: boxDropdownValue.value,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: boxItemList.map((String items) {
        return DropdownMenuItem(
          value: items,
          child:
              Text(items, style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        boxDropdownValue.value = newValue!;
      },
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
                buildRowText(title: 'Select Class',width: 160),
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
                buildRowText(title: 'Start Date',width: 160),
                Expanded(
                  child: GestureDetector(
                    child: Utils().textFormFiledView(
                      hintText: 'dd-MM-yyyy',
                      controller: startDateInputController,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.calendar_month),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return onTextEmptyMsg();
                        }else if(value.isAlphabetOnly){
                          return 'Please enter numeric Date value';
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          setState(() {
                            startDate =pickedDate.millisecondsSinceEpoch;
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
                buildRowText(title: 'End Date',width: 160),
                Expanded(
                  child: GestureDetector(
                    child: Utils().textFormFiledView(
                      hintText: 'dd-MM-yyyy',
                      controller: endDateInputController,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.calendar_month),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return onTextEmptyMsg();
                        }else if(value.isAlphabetOnly){
                          return 'Please enter numeric Date value';
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          setState(() {
                            endDateInputController.text = formattedDate;
                            endDate = pickedDate.millisecondsSinceEpoch;
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
                buildRowText(title: 'No. of Pages',width: 160),
                Expanded(
                  child: Utils().textFormFiledView(
                    controller: noOfPagesController,
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return onTextEmptyMsg();
                      }else if(value.isAlphabetOnly){
                        return 'Please enter numeric number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String onTextEmptyMsg() => 'Please enter some text';

  DropdownButton<String> buildSelectClassNameDropDownValue() {
    return DropdownButton<String>(
      underline: Container(),
      value: selectedItemClassNameDropdownValue.value,
      isDense: true,
      elevation: 0,
      dropdownColor: Colors.white,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: selectedItemClassNameList.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items, style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        selectedItemClassNameDropdownValue.value = newValue!;
      },

    );
  }



  Widget buildDocumentDetailsCard() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Row(
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              buildRowText(title: 'Record Date',width: 160),
              Expanded(
                child: Utils().textFormFiledView(
                  controller: recordDateController,
                  hintText: '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return onTextEmptyMsg();
                    }else if(value.isAlphabetOnly){
                      return 'Please enter numeric Date value';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRowText(title: 'Subject',
              width: 160),
              Expanded(
                child: Utils().textFormFiledView(
                  controller: subjectController,
                  hintText: '',
                  maxLine: 4,
                  minLines: 4,
                  isMaxLength: true,
                  maxLength: 400,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return onTextEmptyMsg();
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              buildRowText(title: 'Application Name',width: 160),
              Expanded(
                child: Utils().textFormFiledView(
                  controller: applicationNameController,
                  hintText: '',
                  isMaxLength: true,
                  maxLength: 100,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return onTextEmptyMsg();
                    }else if(value.isNumericOnly){
                      return 'Please enter only alphabetic word';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              buildRowText(title: 'Order No',width: 160),
              Expanded(
                child: Utils().textFormFiledView(
                  controller: orderNoController,
                  hintText: '',
                  isMaxLength: true,
                  maxLength: 100,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return onTextEmptyMsg();
                    }else if(value.isAlphabetOnly){
                      return 'Please enter numeric value';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              buildRowText(title: 'Remarks',width: 160),
              Expanded(
                child: Utils().textFormFiledView(
                  controller: remarksController,
                  hintText: '',
                  isMaxLength: true,
                  maxLength: 100,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return onTextEmptyMsg();
                    }else if(value.isNumericOnly){
                      return 'Please enter text value';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildRowText({required String title, double? width}) {
    return Container(
      alignment: Alignment.centerLeft,
      width: width,
      padding: const EdgeInsets.only(right: 10, top: 14, bottom: 8),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  void clearTextFiledData() {
    subjectController.clear();
    startDateInputController.clear();
    remarksController.clear();
    recordDateController.clear();
    orderNoController.clear();
    fileNoController.clear();
    endDateInputController.clear();
    noOfPagesController.clear();
    applicationNameController.clear();
    departmentNameItemNameList.clear();

     rackItemNameDropdownValue.close();
     selectedItemClassNameDropdownValue.close();
     boxDropdownValue.close();

  }
}
