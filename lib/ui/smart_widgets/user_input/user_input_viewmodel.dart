import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:spaced_lite/datamodels/api_models.dart';
import 'package:spaced_lite/services/api/api.dart';
import 'package:stacked_services/stacked_services.dart';

class UserInputViewModel extends FutureViewModel<Task> {
  final String id;
  UserInputViewModel({required this.id});

  Task task = Task();
  final formKey = GlobalKey<FormState>();
  final _navigationService = locator<NavigationService>();
  final _api = locator<Api>();
  int entry = 0;
  int copies = 1;

  void incrementCopies() {
    copies++;
    notifyListeners();
  }

  void decrementCopies() {
    if (copies > 1) {
      copies--;
    }
    notifyListeners();
  }

  Widget getSuffixText() {
    if (copies == 1) {
      return Text('suffix: $entry');
    } else {
      return Text('suffix: from $entry to ${entry + copies - 1}');
    }
  }

  String getSuffix(int value) {
    String suffix = '';
    if (value <= 9) {
      suffix = '00$value';
    } else if (value <= 99) {
      suffix = '0$value';
    } else {
      suffix = value.toString();
    }
    return suffix;
  }

  TextEditingController textEditingControllerPC = TextEditingController();
  TextEditingController textEditingControllerWP = TextEditingController();

  void setTextEditingControllerWP(String value) {
    textEditingControllerWP.text = value;
    notifyListeners();
  }

  void setTextEditingControllerPC(String value) async {
    if (await _api.isDuplicate(value)) {
      entry = await _api.getLatestEntryForProjectCode(value) + 1;
    } else {
      entry = 0;
    }
    textEditingControllerPC.text = value;
    notifyListeners();
  }

  // String _selectedCity;

  Future<List<String>> getSuggestions(String field, String pattern) async {
    return await _api.getSuggestions(field, pattern);
  }

  handleForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      bool success = true;
      int i = copies;
      for (i; i >= 1; i--) {
        task.entry = entry + i - 1;
        task.task =
            '${task.projectCode.toUpperCase()}-${getSuffix(task.entry)}';
        success = await _api.addNewTask(task);
        // await Future.delayed(Duration(seconds: 1));
        // if (id == '') {
        // }
        // else {
        //   success = await _api.editTask(id, task);
        // }
      }
      if (success && i <= 0) {
        // Navigator.pop(context, 'changed');
        _navigationService.back(result: 'changed');
        return true;
      } else if (!success && i <= 0) {
        _navigationService.back(result: 'not_changed');
        // Navigator.pop(context, 'not_changed');
        return true;
      }
    }
  }

  @override
  Future<Task> futureToRun() async {
    if (id != '') {
      task = await _api.getTaskForId(id);
      textEditingControllerPC.text = task.projectCode;
      return task;
    } else {
      textEditingControllerPC.text = '';
      // print('the id from user input page is ${id}');
      return task;
    }
  }
}
