// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String? ?? '',
      projectCode: json['projectCode'] as String? ?? 'none',
      task: json['task'] as String? ?? '',
      workspaceName: json['workspaceName'] as String? ?? '',
      entry: json['entry'] as int? ?? 0,
      isActive: json['isActive'] as int? ?? 1,
      status: json['status'] as int? ?? 0,
      timesPracticed: json['timesPracticed'] as int? ?? 0,
      lastPracticed: json['lastPracticed'] as String? ?? 'new',
      nextDate: json['nextDate'] as String? ?? 'new',
      eFactor: (json['eFactor'] as num?)?.toDouble() ?? 2.5,
      interval: json['interval'] as int? ?? 1,
      reviewDates: json['reviewDates'] as String? ?? '[]',
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'projectCode': instance.projectCode,
      'task': instance.task,
      'entry': instance.entry,
      'workspaceName': instance.workspaceName,
      'isActive': instance.isActive,
      'status': instance.status,
      'timesPracticed': instance.timesPracticed,
      'lastPracticed': instance.lastPracticed,
      'nextDate': instance.nextDate,
      'eFactor': instance.eFactor,
      'interval': instance.interval,
      'reviewDates': instance.reviewDates,
    };
