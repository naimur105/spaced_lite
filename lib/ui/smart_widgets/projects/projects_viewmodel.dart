import 'dart:developer';

import 'package:stacked/stacked.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:spaced_lite/datamodels/api_models.dart';
import 'package:spaced_lite/services/api/api.dart';

class ProjectsViewModel extends FutureViewModel {
  List<Project> projects = [];
  List<Task> tasks = [];
  List<String> projectCodes = [];
  List<String> projectNames = [];
  final _api = locator<Api>();
  @override
  Future futureToRun() async {
    tasks = [];
    projects = [];
    projectCodes = [];
    tasks = await _api.getAllTasks();
    for (var task in tasks) {
      projectCodes.add(task.projectCode);
    }
    projectCodes = projectCodes.toSet().toList();
    int i = 0;
    bool isActive = false;
    for (var projectCode in projectCodes) {
      isActive = await _api.isProjectActive(projectCode);
      projects.add(Project(projectCode: projectCode, isActive: isActive));
      i++;
    }
    // inspect(projects);
  }

  Future<bool> toggleProjectActivity(Project project, bool newValue) async {
    int value = newValue ? 1 : 0;
    var filteredTasks =
        await _api.getFilteredTasks([project.projectCode, 'All', 'All']);
    for (var task in filteredTasks) {
      task.isActive = value;
      await _api.editTask(task.id, task);
    }
    await futureToRun();
    notifyListeners();
    return true;
  }
}

class Project {
  String projectCode;
  bool isActive;

  Project({required this.projectCode, required this.isActive});
  // get projectName => projectName;
}
