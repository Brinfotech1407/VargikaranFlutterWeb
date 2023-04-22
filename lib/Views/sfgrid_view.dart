import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vargikaran_web_app/constants.dart';
import 'package:vargikaran_web_app/date_time_utils.dart';
import 'package:vargikaran_web_app/layout/adaptive.dart';
import 'package:vargikaran_web_app/model/files_model.dart';
import 'package:vargikaran_web_app/services/firestore_services.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({Key? key, required this.arrFilesList})
      : super(key: key);
  final List<FileModel> arrFilesList;

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  late FilesInfoDataGridSource filesDataSource;
  late bool isWebOrDesktop;
  GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    super.initState();
    //Todo needs to fill DataSource
    initializeDataSource();
  }

  Future<void> initializeDataSource() async {
    filesDataSource = FilesInfoDataGridSource(
        filesCollection: widget.arrFilesList, filesDataCount: 2);
  }

  @override
  Widget build(BuildContext context) {
    isWebOrDesktop = isDisplayDesktop(context);
    return SfDataGrid(
      defaultColumnWidth: 150,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      source: filesDataSource,
      isScrollbarAlwaysShown: true,
      horizontalScrollController: ScrollController(),
      verticalScrollController: ScrollController(),
      allowColumnsResizing: true,
      allowSorting: true,
      allowPullToRefresh: true,
      onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
        setState(() {
          columnWidths[details.column.columnName] = details.width;
        });
        return true;
      },
      loadMoreViewBuilder: _buildLoadMoreView,
      columns: _getColumns(),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      height: 60.0,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: BorderDirectional(
          top: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.26)),
        ),
      ),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color?>(Colors.blue),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildLoadMoreView(BuildContext context, LoadMoreRows loadMoreRows) {
    Future<String> loadRows() async {
      // Call the loadMoreRows function to call the
      // DataGridSource.handleLoadMoreRows method. So, additional
      // rows can be added from handleLoadMoreRows method.
      await loadMoreRows();
      return Future<String>.value('Completed');
    }

    return FutureBuilder<String>(
      initialData: 'Loading',
      future: loadRows(),
      builder: (BuildContext context, AsyncSnapshot<String> snapShot) {
        return snapShot.data == 'Loading'
            ? _buildProgressIndicator()
            : SizedBox.fromSize(size: Size.zero);
      },
    );
  }

  Map<String, double> columnWidths = {
    fnNo: double.nan,
    subject: double.nan,
    applicationName: double.nan,
    orderNo: double.nan,
    branch: double.nan,
    department: double.nan,
    noOfPages: double.nan,
    classes: double.nan,
    startDate: double.nan,
    endDate: double.nan,
    recordDate: double.nan,
    entryDate: double.nan,
    location: double.nan,
    remark: double.nan,
  };

  List<GridColumn> _getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: fnNo,
          width: columnWidths[fnNo]!,
          minimumWidth: 30.0,
          columnWidthMode:
              !isWebOrDesktop ? ColumnWidthMode.none : ColumnWidthMode.fill,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'FN.NO.',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          columnName: subject,
          minimumWidth: 30.0,
          columnWidthMode:
              !isWebOrDesktop ? ColumnWidthMode.none : ColumnWidthMode.fill,
          width: columnWidths[subject]!,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'Subject',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          columnName: applicationName,
          minimumWidth: 30.0,
          width: columnWidths[applicationName]!,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'Applicant Name',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          width: columnWidths[orderNo]!,
          minimumWidth: 30.0,
          columnName: orderNo,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'Order No.',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          columnName: branch,
          minimumWidth: 30.0,
          width: columnWidths[branch]!,
          columnWidthMode:
              !isWebOrDesktop ? ColumnWidthMode.none : ColumnWidthMode.fill,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'Branch',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          width: columnWidths[department]!,
          minimumWidth: 30.0,
          columnName: department,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'Department',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          width: columnWidths[noOfPages]!,
          minimumWidth: 30.0,
          columnName: noOfPages,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'Pages',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          width: columnWidths[classes]!,
          minimumWidth: 30.0,
          columnName: classes,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'Class',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          width: columnWidths[startDate]!,
          minimumWidth: 30.0,
          columnName: startDate,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'Start Date',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          width: columnWidths[endDate]!,
          minimumWidth: 30.0,
          columnName: endDate,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'End Date',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          width: columnWidths[recordDate]!,
          minimumWidth: 30.0,
          columnName: recordDate,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'Record Date',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          width: columnWidths[entryDate]!,
          minimumWidth: 30.0,
          columnName: entryDate,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'Entry Date',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          columnName: location,
          minimumWidth: 30.0,
          width: columnWidths[location]!,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'Location',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
      GridColumn(
          width: columnWidths[remark]!,
          minimumWidth: 30.0,
          columnName: remark,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child:  Text(
                'Remark',
                overflow: TextOverflow.ellipsis,
                style: columnHeaderTextStyle(),
              ))),
    ];
  }

  TextStyle columnHeaderTextStyle() {
    return const TextStyle(fontWeight: FontWeight.bold);
  }
}

/// Set order's data collection to data grid source.
class FilesInfoDataGridSource extends DataGridSource {
  /// Creates the order data source class with required details.
  FilesInfoDataGridSource({
    this.filesDataCount,
    this.filesCollection,
    this.culture,
    bool? isFilteringSample,
  }) {
    this.isFilteringSample = isFilteringSample ?? false;
    files = filesCollection ?? [];
    buildDataGridRows();
  }

  /// Localization Source.
  String? culture;

  /// Get data count of an order.
  int? filesDataCount;

  /// Instance of an order.
  List<FileModel> files = <FileModel>[];

  /// Instance of an order collection for rtl sample
  List<FileModel>? filesCollection;

  /// Instance of DataGridRow.
  List<DataGridRow> dataGridRows = <DataGridRow>[];

  /// Checks whether the source is used for the filtering sample or not.
  late bool isFilteringSample;

  /// Building DataGridRows.
  void buildDataGridRows() {
    dataGridRows = files.map<DataGridRow>((FileModel order) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(
            columnName: getColumnName('fnNo'), value: order.fnNo),
        DataGridCell<String>(
            columnName: getColumnName('subject'), value: order.subject),
        DataGridCell<String>(
            columnName: getColumnName('applicationName'),
            value: order.applicationName),
        DataGridCell<String>(
            columnName: getColumnName('orderNo'), value: order.orderNo),
        DataGridCell<String>(
            columnName: getColumnName('branch'), value: order.branch),
        DataGridCell<String>(
            columnName: getColumnName('department'), value: order.department),
        DataGridCell<String>(
            columnName: getColumnName('noOfPages'), value: order.noOfPages),
        DataGridCell<String>(
            columnName: getColumnName('classes'), value: order.classes),
        DataGridCell<int>(
            columnName: getColumnName('startDate'), value: order.startDate),
        DataGridCell<int>(
            columnName: getColumnName('endDate'), value: order.endDate),
        DataGridCell<String>(
            columnName: getColumnName('recordDate'), value: order.recordDate),
        DataGridCell<int>(
            columnName: getColumnName('entryDate'), value: order.entryDate),
        DataGridCell<String>(
            columnName: getColumnName('location'),
            value:
                '${order.cupBoardName} / ${order.rackName} / ${order.boxName}'),
        DataGridCell<String>(
            columnName: getColumnName('remark'), value: order.remarks),
      ]);
    }).toList();
  }

  // Overrides

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = dataGridRows.indexOf(row);
    Color backgroundColor = Colors.transparent;
    /*if (rowIndex % 2 == 0 && culture == null) {
      backgroundColor = const Color.fromRGBO(0, 116, 227, 1).withOpacity(0.07);
    }*/
    return DataGridRowAdapter(color: backgroundColor, cells: <Widget>[
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[2].value.toString(),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(row.getCells()[3].value.toString()),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[5].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[6].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[7].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          DateTimeUtils.getFilterFormattedDate(row.getCells()[8].value)
              .toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          DateTimeUtils.getFilterFormattedDate(row.getCells()[9].value)
              .toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[10].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          DateTimeUtils.getFilterFormattedDate(row.getCells()[11].value)
              .toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[12].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[13].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }

  @override
  Future<void> handleLoadMoreRows() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    files = await getFiles(files, FireStoreServices().noOfRecords);
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Future<void> handleRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    files = await getFiles(files, FireStoreServices().noOfRecords);
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    Widget? widget;
    Widget buildCell(String value, EdgeInsets padding, Alignment alignment) {
      return Container(
        padding: padding,
        alignment: alignment,
        child: Text(value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w500)),
      );
    }

    return widget;
  }

  /// Provides the column name.
  String getColumnName(String columnName) {
    return columnName;
  }

  /// Update DataSource
  void updateDataSource() {
    notifyListeners();
  }

  //  Order Data's

  /// Get orders collection
  Future<List<FileModel>> getFiles(List<FileModel> filesData, int count,
      {String? culture}) async {
    final int startIndex = filesData.isNotEmpty ? filesData.length : 0;
    final int endIndex = startIndex + count;

    List<FileModel>? fileData = await FireStoreServices().getFilesData(count);

    return fileData ?? filesData;
  }
}
