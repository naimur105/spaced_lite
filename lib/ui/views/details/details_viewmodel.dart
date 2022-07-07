import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:spaced_lite/app/app.router.dart';
import 'package:spaced_lite/datamodels/api_models.dart';
import 'package:spaced_lite/services/api/api.dart';
import 'package:stacked_services/stacked_services.dart';

class DetailsViewModel extends FutureViewModel<Task> {
  final String id;
  DetailsViewModel({required this.id});
  final _navigationService = locator<NavigationService>();

  final _api = locator<Api>();
  Task task = Task();
  bool isProjectActive = true;

  String getLastPracticed(String dateTime) {
    if (dateTime != 'new') {
      return DateFormat('EEEEEE, MMM-d-yyyy')
          .format(DateTime.tryParse(dateTime)!)
          .toString();
    } else {
      return dateTime;
    }
  }

  String getNextDate(String dateTime) {
    if (dateTime != 'new') {
      return DateFormat('EEEEEE, MMM-d-yyyy')
          .format(DateTime.tryParse(dateTime)!)
          .toString();
    } else {
      return dateTime;
    }
  }

  String getWhen() {
    if (task.timesPracticed == 0) {
      return 'new';
    } else {
      Duration duration =
          DateTime.tryParse(task.nextDate)!.difference(DateTime.now());
      return 'in ${duration.inDays.toString()}d';
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.deepOrangeAccent[700]!;
      case 1:
        return Colors.orange[600]!;
      case 3:
        return Colors.green;
      case 4:
        return Colors.blueAccent;
      case 5:
        return Colors.blueAccent[700]!;
      default:
        return Colors.deepOrangeAccent[700]!;
    }
  }

  @override
  Future<Task> futureToRun() async {
    task = await _api.getTaskForId(id);
    isProjectActive = await _api.isProjectActive(task.projectCode);
    return task;
  }

  deleteTask() async {
    await _api.deleteTask(id);
    // Navigator.pop(context, 'changed');
    _navigationService.back(result: 'changed');
  }

  // FutureOr onGoBack(dynamic value) async {
  //   Task testTask = await _api.getTaskForId(id);
  //   if (task != testTask) {
  //     task = testTask;
  //     notifyListeners();
  //   } else {
  //     return;
  //   }
  // }
  var navigationResult;
  // navigateToEditPage(String id) async {
  //   navigationResult = await _navigationService.navigateTo(Routes.editTaskView,
  //       arguments: EditTaskViewArguments(id: id))!;
  //   if (navigationResult == 'changed') {
  //     task = await _api.getTaskForId(id);
  //     notifyListeners();
  //   } else {
  //     return;
  //   }
  // }

  Future<bool> toggleActivityOfTask() async {
    if (task.isActive == 0) {
      task.isActive = 1;
    } else {
      task.isActive = 0;
    }
    bool success = await _api.editTask(id, task);
    if (success) {
      notifyListeners();
      return true;
    } else {
      throw error('task activity not toggled successfully');
    }
  }

  Future<bool> popNavigate() async {
    Task testTask = await _api.getTaskForId(id);
    if (task != testTask) {
      // Navigator.pop(context, 'changed');
      _navigationService.back(result: 'changed');
      return true;
    } else {
      // Navigator.pop(context, 'not_changed');
      _navigationService.back(result: 'not_changed');
      return true;
    }
  }

  // Future<bool> toggleProjectActivity(String projectCode) async {
  //   List<Task> tasks =
  //       await _api.getFilteredTasks([task.projectCode, 'All', 'All']);

  //   print('this has all tasks with project code ${task.projectCode}');
  //   inspect(tasks);
  //   try {
  //     if (isProjectActive) {
  //       for (var task in tasks) {
  //         task.isActive = 0;
  //         await _api.editTask(task.id, task);
  //       }
  //       task.isActive = 0;
  //       isProjectActive = false;
  //     } else {
  //       for (var task in tasks) {
  //         task.isActive = 1;
  //         await _api.editTask(task.id, task);
  //       }
  //       task.isActive = 1;
  //       isProjectActive = true;
  //     }
  //     notifyListeners();
  //     return true;
  //   } on Exception catch (e) {
  //     rethrow;
  //   }
  // }
}
