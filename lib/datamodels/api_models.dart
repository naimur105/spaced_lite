import 'package:json_annotation/json_annotation.dart';

part 'api_models.g.dart';

@JsonSerializable()
class Task {
  String id;
  String projectCode;
  int entry;
  int isActive;
  int status;
  int timesPracticed;
  String lastPracticed;
  String nextDate;
  double eFactor;
  int interval;
  String reviewDates;

  Task({
    this.id = '',
    this.projectCode = 'none',
    this.entry = 0,
    this.isActive = 1,
    this.status = 0,
    this.timesPracticed = 0,
    this.lastPracticed = 'new',
    this.nextDate = 'new',
    this.eFactor = 2.5,
    this.interval = 1,
    this.reviewDates = '[]',
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, Object?> toJson() => _$TaskToJson(this);
}
