import 'package:json_annotation/json_annotation.dart';

//here file name and as part name both must be same
part 'files_model.g.dart';

@JsonSerializable()
class FileModel {
  String? id;
  String? fnNo;
  String? department;
  String? branch;
  String? recordDate;
  int? entryDate;
  String? subject;
  String? applicationName;
  String? remarks;
  String? orderNo;
  String? classes;
  int? startDate;
  int? endDate;
  String? noOfPages;
  String? cupBoardName;
  String? rackName;
  String? boxName;

  FileModel({
    this.id,
    this.fnNo,
    this.department,
    this.branch,
    this.recordDate,
    this.entryDate,
    this.subject,
    this.applicationName,
    this.remarks,
    this.orderNo,
    this.classes,
    this.startDate,
    this.endDate,
    this.noOfPages,
    this.cupBoardName,
    this.rackName,
    this.boxName,
  });

  @override
  List<Object?> get props => [
    id,
    fnNo,
    department,
    branch,
    recordDate,
    entryDate,
    subject,
    applicationName,
    remarks,
    orderNo,
    classes,
    startDate,
    endDate,
    noOfPages,
    cupBoardName,
    rackName,
    boxName
  ];

  /// Connect the generated [_$AddFilesDetailsFromJson] function to the `fromJson`
  /// factory.
  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);

  /// Connect the generated [_$AddFilesDetailsToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FileModelToJson(this);
}
