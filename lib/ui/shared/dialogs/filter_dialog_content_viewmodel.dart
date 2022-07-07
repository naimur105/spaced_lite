import 'package:stacked/stacked.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:spaced_lite/services/api/api.dart';

class FilterDialogContentViewModel extends FutureViewModel {
  String projectCodeValue = 'One';
  String workspaceValue = 'One';
  String activityValue = 'Active';
  List<String> projectCodes = ['these', 'shouldn\'t', 'be', 'here'];
  List<String> workspaces = ['these', 'shouldn\'t', 'be', 'here'];
  List<String> activities = ['active', 'inactive', 'All'];
  final _api = locator<Api>();

  void setProjectCodeValue(String? newValue) {
    projectCodeValue = newValue!;
    notifyListeners();
  }

  void setWorkspaceValue(String? newValue) {
    workspaceValue = newValue!;
    notifyListeners();
  }

  void setActivityValue(String? newValue) {
    activityValue = newValue!;
    notifyListeners();
  }

  @override
  Future futureToRun() async {
    projectCodes = await _api.getProjectCodes(workspace: 'All');
    projectCodes.add('All');
    workspaces = await _api.getWorkspaces();
    workspaces.add('All');
    projectCodeValue = projectCodes.last;
    workspaceValue = workspaces.last;
    activityValue = activities.last;
  }
}
