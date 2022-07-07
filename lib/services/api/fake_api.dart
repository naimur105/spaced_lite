import 'dart:html';

import 'package:spaced_lite/datamodels/api_models.dart';
import 'package:spaced_lite/services/api/api.dart';

class FakeApi implements Api {
  @override
  Future<List<Task>> getAllTasks() async {
    await Future.delayed(Duration(seconds: 1));
    return List<Task>.generate(
        10, (index) => Task(id: DateTime.now().toString()));
  }

  @override
  Future<Task> getTaskForId(String id) async {
    await Future.delayed(Duration(seconds: 1));
    if (DateTime.now().hour ==
        DateTime.tryParse(DateTime.now().hour.toString())) {
      return Task(
        projectCode: 'p1',
        timesPracticed: 7,
      );
    } else {
      throw Exception('not found');
    }
  }

  @override
  Future<List<Task>> getTasksForToday() async {
    await Future.delayed(Duration(seconds: 1));
    return List<Task>.generate(
        5, (index) => Task(id: DateTime.now().toString()));
  }

  @override
  Future<bool> addNewTask(Task task) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  @override
  Future<bool> deleteTask(String id) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  @override
  Future<bool> editTask(String id, Task task) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  @override
  Future<bool> toggleActive(String id) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  @override
  Future initialise() {
    // TODO: implement initialise
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getSuggestions(String field, String pattern) {
    // TODO: implement getSuggestions
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getProjectCodes({required String workspace}) {
    // TODO: implement getProjectCodes
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getWorkspaces() {
    // TODO: implement getWorkspaces
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getFilteredTasks(List<String> parameters) {
    // TODO: implement getFilteredTasks
    throw UnimplementedError();
  }

  @override
  Future<bool> isProjectActive(String projectCode) {
    // TODO: implement isProjectActive
    throw UnimplementedError();
  }

  @override
  Future<bool> exportTasks() {
    // TODO: implement exportTasks
    throw UnimplementedError();
  }

  @override
  Future<bool> importTasks() {
    // TODO: implement importTasks
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> filterTasksByTitle(String value) {
    // TODO: implement filterTasksByTitle
    throw UnimplementedError();
  }

  @override
  Future<bool> isDuplicate(String value) {
    throw UnimplementedError();
  }

  @override
  Future<int> getLatestEntryForProjectCode(String value) {
    // TODO: implement getLatestEntryForProjectCode
    throw UnimplementedError();
  }
}
