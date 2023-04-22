// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
      id: json['id'] as String?,
      fnNo: json['fnNo'] as String?,
      department: json['department'] as String?,
      branch: json['branch'] as String?,
      recordDate: json['recordDate'] as String?,
      entryDate: json['entryDate'] as int?,
      subject: json['subject'] as String?,
      applicationName: json['applicationName'] as String?,
      remarks: json['remarks'] as String?,
      orderNo: json['orderNo'] as String?,
      classes: json['classes'] as String?,
      startDate: json['startDate'] as int?,
      endDate: json['endDate'] as int?,
      noOfPages: json['noOfPages'] as String?,
      cupBoardName: json['cupBoardName'] as String?,
      rackName: json['rackName'] as String?,
      boxName: json['boxName'] as String?,
    );

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'id': instance.id,
      'fnNo': instance.fnNo,
      'department': instance.department,
      'branch': instance.branch,
      'recordDate': instance.recordDate,
      'entryDate': instance.entryDate,
      'subject': instance.subject,
      'applicationName': instance.applicationName,
      'remarks': instance.remarks,
      'orderNo': instance.orderNo,
      'classes': instance.classes,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'noOfPages': instance.noOfPages,
      'cupBoardName': instance.cupBoardName,
      'rackName': instance.rackName,
      'boxName': instance.boxName,
    };
