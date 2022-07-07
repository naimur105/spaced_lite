import 'dart:convert';

import 'package:stacked/stacked.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:spaced_lite/datamodels/api_models.dart';
import 'package:spaced_lite/services/api/api.dart';

class FloatingBoxBottomSheetViewModel extends BaseViewModel {
  final _api = locator<Api>();

  Map<int, int> intervalMap = <int, int>{};
  Map<int, double> eFactorMap = <int, double>{};
  int timesRepeated = 25;
  int _interval = 1;
  late double _eFactor;
  late Task _task;
  late String _today;
  late int _timesRepeated;
  late String _lastPracticed;
  late String _nextDate;
  late List _reviewDatesList;

  prepareSchedulefor(Task task) {
    _task = task;
    for (int status = 0; status <= 5; status++) {
      _eFactor =
          task.eFactor + (0.1 - (5 - status) * (0.08 + (5 - status) * 0.02));
      if (_eFactor < 1.3) {
        _eFactor = 1.3;
      }
      if (timesRepeated <= 1) {
        _interval = 1;
      } else if (timesRepeated == 2) {
        _interval = 6;
      } else if (timesRepeated > 2 && status < 3) {
        _interval = 1;
      } else if (timesRepeated > 2 && status >= 3) {
        _interval = (task.interval * _eFactor).round();
      }
      intervalMap[status] = _interval;
      eFactorMap[status] = _eFactor;
    }
  }

  updateTask(int status) async {
    //prepare task;
    _today = DateTime.now().toString();
    _task.status = status;
    _interval = intervalMap[status]!;
    _task.interval = _interval;
    _eFactor = eFactorMap[status]!;
    _task.eFactor = _eFactor;
    _timesRepeated = _task.timesPracticed + 1;
    _task.timesPracticed = _timesRepeated;
    _lastPracticed = _today;
    _task.lastPracticed = _lastPracticed;
    _nextDate =
        DateTime.tryParse(_today)!.add(Duration(days: _interval)).toString();
    _task.nextDate = _nextDate;
    _reviewDatesList = json.decode(_task.reviewDates);
    _reviewDatesList.add(_today);
    _task.reviewDates = json.encode(_reviewDatesList);
    //send it to Api;
    try {
      await _api.editTask(_task.id, _task);
    } catch (e) {
      rethrow;
    }
  }
}
