// import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:spaced_lite/app/app.router.dart';
import 'package:spaced_lite/datamodels/api_models.dart';
import 'package:spaced_lite/enums/basic_dialog_status.dart';
import 'package:spaced_lite/enums/bottom_sheet_type.dart';
import 'package:spaced_lite/enums/dialog_type.dart';
import 'package:spaced_lite/services/api/api.dart';
import 'package:stacked_services/stacked_services.dart';

class TaskListViewModel extends FutureViewModel<List<Task>> {
  final String type;
  TaskListViewModel({required this.type});
  final _api = locator<Api>();
  late List<Task> tasks;
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();

  var navigationResult;

  navigateToHelpPage() async {
    navigationResult = await _navigationService.navigateTo(Routes.helpView);
  }

  navigateToDetailsPage(String id) async {
    navigationResult = await _navigationService.navigateTo(Routes.detailsView,
        arguments: DetailsViewArguments(id: id));
    // print(navigationResult);

    if (navigationResult == 'changed') {
      await futureToRun();
      notifyListeners();
    }
    // _navigationService
    //     .navigateTo(Routes.detailsView,
    //         arguments: DetailsViewArguments(id: id))!
    //     .then(onGoBack);
  }

  @override
  Future<List<Task>> futureToRun() async {
    await _api.initialise();
    if (type == 'all') {
      tasks = await _api.getAllTasks();
    } else if (type == 'today') {
      List<Task> todayTasks = await _api.getTasksForToday();
      tasks = [];
      for (var task in todayTasks) {
        if (task.isActive != 0 && task.timesPracticed > 0) {
          tasks.add(task);
        }
      }
    }
    return tasks;
  }

  void findTasksBy(String value) async {
    tasks = await _api.filterTasksByTitle(value);
    notifyListeners();
  }

  // FutureOr onGoBack(dynamic value) async {
  //   List<Task> testTasks = await _api.getAllTasks();
  //   if (tasks != testTasks) {
  //     tasks = testTasks;
  //     notifyListeners();
  //   } else {
  //     return;
  //   }
  // }

  String getScheduleDate(String dateTime) {
    DateTime _today = DateTime.now();
    DateTime _schedule = DateTime.tryParse(dateTime)!;
    int duration = _schedule.difference(_today).inHours;
    //The returned [Duration] will be negative if [other] occurs after [this].
    //checking if it's in the future:
    if (duration > 24) {
      return DateFormat('EEE, MMM-d').format(_schedule).toString();
      //checking if it's tomorrow
    } else if (duration > 0 && duration <= 24) {
      return 'tomorrow';
    } else if (DateFormat('EEE, MMM-d').format(_today) ==
        DateFormat('EEE, MMM-d').format(_schedule)) {
      return 'today';
    }
    //checking if it's yesterday
    else if (duration >= -48 && duration < -24) {
      return 'yesterday';
      //check if it's older than yesterday
    } else if (duration < -48) {
      return '${((duration * (-1)) / 24).round()}d ago';
    } else {
      return DateFormat('EEE, MMM-d').format(_schedule).toString();
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.deepOrangeAccent[700]!;
      case 1:
        return Colors.orange[600]!;
      case 2:
        return Colors.yellowAccent;
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

  showCustomBottomSheet(Task task) async {
    var sheetResponse = await _bottomSheetService.showCustomSheet(
      isScrollControlled: true,
      showIconInMainButton: true,
      showIconInAdditionalButton: true,
      showIconInSecondaryButton: true,
      data: task,
      takesInput: true,
      variant: BottomSheetType.floating,
      title: "How'd it go?",
      description: task.task,
      useRootNavigator: true,
      // mainButtonTitle: 'Awesomee!',
      // secondaryButtonTitle: 'This is coollllllll',
    );
    // print('confirmationResponse confirmed: ${sheetResponse?.confirmed}');
    if (sheetResponse != null && sheetResponse.confirmed) {
      await futureToRun();
      notifyListeners();
    }
  }

  showFilterDialog() async {
    final dialogResult = await _dialogService.showCustomDialog(
      barrierDismissible: true,
      variant: DialogType.filter,
      data: BasicDialogStatus.success,
      title: 'Filter',
      description: 'This is the description',
      secondaryButtonTitle: 'cancel',
      mainButtonTitle: 'ok',
    );

    if (dialogResult!.confirmed) {
      // take me to a screen that has a list of all the region documents available
      tasks = await _api.getFilteredTasks(dialogResult.data);
      notifyListeners();
    }
  }
}
