import 'package:spaced_lite/datamodels/api_models.dart';

abstract class Api {
  Future initialise();
  Future<List<Task>> getTasksForToday();
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getFilteredTasks(List<String> parameters);
  Future<List<Task>> filterTasksByTitle(String value);
  Future<List<String>> getSuggestions(String field, String pattern);
  Future<List<String>> getProjectCodes({required String workspace});
  Future<List<String>> getWorkspaces();
  Future<Task> getTaskForId(String id);
  Future<bool> addNewTask(Task task);
  Future<bool> editTask(String id, Task task);
  Future<bool> deleteTask(String id);
  Future<bool> toggleActive(String id);
  Future<bool> isProjectActive(String projectCode);
  Future<bool> importTasks();
  Future<bool> exportTasks();
  Future<bool> isDuplicate(String value);
  Future<int> getLatestEntryForProjectCode(String value);
}
