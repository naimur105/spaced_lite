import 'package:stacked/stacked.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:spaced_lite/datamodels/api_models.dart';
import 'package:spaced_lite/services/api/api.dart';

class ProfileViewModel extends FutureViewModel {
  final _api = locator<Api>();
  void exportTasks() async {
    await _api.exportTasks();
    notifyListeners();
  }

  void importTasks() async {
    bool isSuccess = await _api.importTasks();
    if (isSuccess) {
      //show success snackbar
      notifyListeners();
    } else {
      print('import was not successful');
    }
  }

  //came from projects viewModel
  List<Project> projects = [];
  List<Task> tasks = [];
  List<String> projectCodes = [];
  List<String> projectNames = [];
  @override
  Future futureToRun() async {
    tasks = [];
    projects = [];
    projectCodes = [];
    projectNames = [];
    tasks = await _api.getAllTasks();
    for (var task in tasks) {
      projectCodes.add(task.projectCode);
    }
    projectCodes = projectCodes.toSet().toList();
    // projectNames = projectNames.toSet().toList();
    int i = 0;
    bool isActive = false;
    for (var projectCode in projectCodes) {
      isActive = await _api.isProjectActive(projectCode);
      projects.add(Project(
          // projectName: projectNames[i],
          projectCode: projectCode,
          isActive: isActive));
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
  // String projectName;

  Project(
      {
      // required this.projectName,
      required this.projectCode,
      required this.isActive});
  // get projectName => projectName;
}
