import 'package:json_annotation/json_annotation.dart';

//here file name and as part name both must be same
part 'admin_model.g.dart';

@JsonSerializable()
class AdminModel {

  int? FNNO;


  AdminModel({
    this.FNNO,
  });

  @override
  List<Object?> get props => [
    FNNO,
  ];

  /// Connect the generated [_$AddFilesDetailsFromJson] function to the `fromJson`
  /// factory.
  factory AdminModel.fromJson(Map<String, dynamic> json) =>
      _$AdminModelFromJson(json);

  /// Connect the generated [_$AddFilesDetailsToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AdminModelToJson(this);
}
