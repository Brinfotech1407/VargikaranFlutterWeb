import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:vargikaran_web_app/Views/add_files.dart';
import 'package:vargikaran_web_app/Views/sfgrid_view.dart';
import 'package:vargikaran_web_app/model/files_model.dart';
import 'package:vargikaran_web_app/services/firestore_services.dart';
import 'package:vargikaran_web_app/utils/vargikarn_utils.dart';
import 'package:vargikaran_web_app/export/save_file_mobile.dart'
if (dart.library.html) 'package:vargikaran_web_app/export/save_file_web.dart' as helper;
import 'package:syncfusion_flutter_pdf/pdf.dart';


class FilesScreen extends StatefulWidget {
  const FilesScreen({Key? key}) : super(key: key);

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  var selectedItemEntryList = [
    '10',
    '20',
    '30',
    '40',
    '50',
  ].obs;
  RxString selectedItemDropdownValue = '10'.obs;
  final searchController = TextEditingController();
  List<FileModel> arrFilesList = [];
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFilesData();
  }

  void getFilesData() {
    FireStoreServices()
        .getFilesData(FireStoreServices().noOfRecords)
        .then((List<FileModel>? value) {
      if (value != null) {
        setState(() {
          arrFilesList = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          buildIconButtonHeaderView(context),
          Divider(thickness: 1, color: Colors.grey.shade200),
          Row(
            children: [
              Obx(
                () => entryDropDownView(),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(right: 10, top: 14, bottom: 8),
                child: const Text(
                  'entries',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(right: 10, top: 14, bottom: 8),
                child: const Text(
                  'Search',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 200,
                child: Utils().textFormFiledView(
                  order: 100,
                  controller: searchController,
                  hintText: '',
                  validator: (value) {},
                ),
              ),
            ],
          ),
          Expanded(
              child: arrFilesList.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridViewScreen(arrFilesList: arrFilesList,sfDataGridKey: sfDataGridKey,)),
        ],
      ),
    );
  }

  Container buildIconButtonHeaderView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'FILES',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade700),
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                      top: 12, bottom: 12, right: 6, left: 6)),
                ),
                onPressed: () async {
                  bool result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddFileScreen()),
                  );
                  if (result) {
                    if (mounted) {
                      setState(() {
                        arrFilesList.clear();
                      });
                    }

                    getFilesData();
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('ADD'),
                    Icon(Icons.add_circle_outline,size: 18),
                  ],
                )),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              exportDataGridToPdf();
            },
            style: TextButton.styleFrom(
              side: const BorderSide(width: 2.0),
            ),
            child: const Text('Print', style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(
            width: 4,
          ),
          TextButton(
            onPressed: () async {
              exportDataGridToPdf();
            },
            style: TextButton.styleFrom(
              side: const BorderSide(width: 2.0, color: Colors.lightBlueAccent),
            ),
            child: const Text('PDF',
                style: TextStyle(color: Colors.lightBlueAccent)),
          ),
          const SizedBox(
            width: 4,
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              side: const BorderSide(width: 2.0, color: Colors.purpleAccent),
            ),
            child:
                const Text('CSV', style: TextStyle(color: Colors.purpleAccent)),
          ),
        ],
      ),
    );
  }

  Future<void> exportDataGridToPdf() async {
    final PdfDocument document = sfDataGridKey.currentState!.exportToPdfDocument(
        fitAllColumnsInOnePage: true);

    final List<int> bytes = document.saveSync();
    await helper.FileSaveHelper.saveAndLaunchFile(bytes, 'VargikarnData.pdf');
    document.dispose();
  }



  Widget entryDropDownView() {
    return Container(
      width: 120,
      margin: const EdgeInsets.all(8),
      child: DropdownButtonFormField<String>(
        isDense: true,
        elevation: 0,
        dropdownColor: Colors.white,
        focusColor: Colors.transparent,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            counterText: "",
            hintStyle: const TextStyle(fontSize: 14),
            focusColor: Colors.black,
            contentPadding: const EdgeInsets.only(left: 10, top: 18, bottom: 8),
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBorder: const OutlineInputBorder()),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        validator: (value) {
          return null;
        },
        value: selectedItemDropdownValue.value,
        icon: const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(Icons.keyboard_arrow_down),
        ),
        items: selectedItemEntryList.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items, style: const TextStyle(fontSize: 14)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          selectedItemDropdownValue.value = newValue!;
        },
      ),
    );
  }
}
