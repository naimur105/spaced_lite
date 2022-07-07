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

  TextEditingController textEditingControllerPC = TextEditingController();

  void setTextEditingControllerPC(String value) async {
    entry = await _api.getLatestEntryForProjectCode(value) + 1;
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
      if (id == '') {
        success = await _api.addNewTask(task);
      } else {
        success = await _api.editTask(id, task);
      }
      if (success) {
        // Navigator.pop(context, 'changed');
        _navigationService.back(result: 'changed');
        return true;
      } else {
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
