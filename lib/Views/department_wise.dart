import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DepartmentWiseScreen extends StatefulWidget {
  const DepartmentWiseScreen({Key? key}) : super(key: key);

  @override
  State<DepartmentWiseScreen> createState() => _DepartmentWiseScreenState();
}

class _DepartmentWiseScreenState extends State<DepartmentWiseScreen> {

  NotesDataSource? notesDataSource;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 200,
      padding: const EdgeInsets.only(bottom: 4),
      child: Padding(
        padding: const EdgeInsets.only(top: 7, bottom: 4),
        child: SfDataGrid(
          source: notesDataSource!,
          gridLinesVisibility:
          GridLinesVisibility.both,
          headerRowHeight: 45,
          rowHeight: 50,
          controller: _controller,
          verticalScrollPhysics:
          const NeverScrollableScrollPhysics(),
          horizontalScrollPhysics:
          const NeverScrollableScrollPhysics(),
          headerGridLinesVisibility:
          GridLinesVisibility.both,
          columns: getGridColumns(),
        ),
      ),
    );
  }
}
class NotesDataSource extends DataGridSource {
  /// Creates the notes data source class with required details.
  NotesDataSource({
    required List<dynamic> notesData,
    required List<NotesGridColumn>? arrGridNotesColumn,
    required VoidCallback? sortingApplied,
  }) {
    this.sortingApplied = sortingApplied;
    _notesData.clear();
    for (int i = 0; i < notesData.length; i++) {
      final dynamic arrItem = notesData[i];
      final int counter = notesData.length - i;
      _notesData.add(
        DataGridRow(
          cells: generateCells(arrItem, arrGridNotesColumn, counter),
        ),
      );
    }
    _arrGridNotesColumn!.addAll(arrGridNotesColumn!);
  }

  final List<DataGridRow> _notesData = <DataGridRow>[];
  VoidCallback? sortingApplied;
  final List<NotesGridColumn>? _arrGridNotesColumn = <NotesGridColumn>[];

  List<DataGridCell<dynamic>> generateCells(
      dynamic e,
      List<NotesGridColumn>? arrGridNotesColumn,
      int counter,
      ) {
    final List<DataGridCell> arrDataGridCell = <DataGridCell>[];

    for (final NotesGridColumn key
    in arrGridNotesColumn ?? <NotesGridColumn>[]) {
      arrDataGridCell.add(
        DataGridCell<dynamic>(
          columnName: key.name!,
          value: getValueFromKey(e, key.name!, counter, key),
        ),
      );
    }

    return arrDataGridCell;
  }

  bool getGridColumn(DataGridCell rowCell) {
    bool isFileColumn = false;
    for (final NotesGridColumn arrColumn in _arrGridNotesColumn!) {
      if (rowCell.columnName == arrColumn.name) {
        if (arrColumn.isFileColumn) {
          return isFileColumn = true;
        }
      }
    }
    return isFileColumn;
  }

  dynamic getValueFromKey(
      dynamic e,
      String key,
      int counter,
      NotesGridColumn columnData,
      ) {
    if (key == 'No') {
      return '$counter';
    }

    if (columnData.isNumericColumn) {
      return e[key] != null ? double.parse(e[key] as String) : 0;
    }
    if (columnData.isFileColumn) {
      return e['_${key}_file_name'] ?? e[key];
    }

    return e[key] != null ? e[key] as String : '';
  }

  @override
  List<DataGridRow> get rows => _notesData;

  @override
  void performSorting(List<DataGridRow> rows) {
    super.performSorting(rows);
    sortingApplied?.call();
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue,
      ) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      child: Text(summaryValue),
    );
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((DataGridCell e) {
          return Container(
            padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            child: Text(
              e.value.toString(),
              style: TextStyle(
                color: getGridColumn(e) ? Colors.blue : null,
              ),
            ),
          );
        }).toList());
  }
}
