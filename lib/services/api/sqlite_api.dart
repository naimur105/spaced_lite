import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:spaced_lite/datamodels/api_models.dart';
import 'package:spaced_lite/services/api/api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';

const String dbName = 'tasks_database.sqlite';

const String tasksTableName = 'tasks';

class SqliteApi implements Api {
  late Database _database;
  @override
  Future initialise() async {
    final dbPath = await getDatabasesPath();
    _database =
        await openDatabase(path.join(dbPath, dbName), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tasks(id TEXT PRIMARY KEY, projectCode TEXT, entry INTEGER, isActive INTEGER, status INTEGER, creationDate TEXT, timesPracticed INTEGER, lastPracticed TEXT, nextDate TEXT, eFactor REAL, interval INTEGER, reviewDates TEXT)');
    }, version: 1);
    return _database;
  }

  @override
  Future<List<Task>> getAllTasks() async {
    List<Task> tasks = <Task>[];
    var tasksTable =
        await _database.query(tasksTableName, orderBy: 'nextDate DESC');
    for (var task in tasksTable) {
      tasks.add(Task.fromJson(task));
    }
    return tasks;
  }

  @override
  Future<List<Task>> getTasksForToday() async {
    DateTime _today = DateTime.now();
    List<Task> tasks = <Task>[];
    var tasksTable =
        await _database.query(tasksTableName, orderBy: 'nextDate DESC');
    for (var task in tasksTable) {
      //Duration difference(DateTime other)
      //The returned [Duration] will be negative if [other] occurs after [this].
      if (DateTime.tryParse(Task.fromJson(task).nextDate)!
          .difference(_today)
          .isNegative) {
        tasks.add(Task.fromJson(task));
      }
    }
    return tasks;
  }
  // @override
  // Future<List<Task>> getTasksForToday() async {
  //   String _today = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  //   List<Task> tasks = <Task>[];
  //   var tasksTable = await _database.query(tasksTableName,
  //       where: "nextDate LIKE ?", whereArgs: ['$_today%']);
  //   for (var task in tasksTable) {
  //     tasks.add(Task.fromJson(task));
  //   }
  //   return tasks;
  // }

  @override
  Future<Task> getTaskForId(String id) async {
    List<Task> tasks = [];

    var taskTable = await _database.query(tasksTableName,
        where: 'id = ?', whereArgs: [id], limit: 1);
    for (var task in taskTable) {
      tasks.add(Task.fromJson(task));
    }
    // inspect(tasks.first);
    return tasks.first;
  }

  @override
  Future<List<String>> getSuggestions(String field, String pattern) async {
    List<String> suggestions = [];
    var taskTable = await _database.query(tasksTableName,
        where: '$field LIKE ?', whereArgs: ['$pattern%']);

    for (var task in taskTable) {
      suggestions.add(task.entries
          .firstWhere((element) => element.key == field)
          .value
          .toString());
    }
    //toSet() will remove duplicate elements, another way: [...{...suggestions}]
    return suggestions.toSet().toList();
  }

  @override
  Future<bool> addNewTask(Task task) async {
    if (DateTime.tryParse(task.id) != null) {
      try {
        await _database.insert(tasksTableName, task.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
        return true;
      } on Exception catch (e) {
        rethrow;
      }
    } else {
      try {
        task.id = DateTime.now().toString();
        task.nextDate = task.id;
        await _database.insert(tasksTableName, task.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
        return true;
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  Future<bool> deleteTask(String id) async {
    try {
      await _database.delete(tasksTableName, where: "id=?", whereArgs: [id]);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> editTask(String id, Task task) async {
    try {
      await _database.update(tasksTableName, task.toJson(),
          where: 'id = ?',
          whereArgs: [id],
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> toggleActive(String id) async {
    Task task = await getTaskForId(id);
    task.isActive == 0 ? task.isActive = 1 : task.isActive = 0;
    try {
      return await editTask(id, task);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getProjectCodes({required String workspace}) async {
    List<String> projectCodes = [];
    List<Task> taskTable = await getFilteredTasks(['All', workspace, 'active']);
    for (var task in taskTable) {
      projectCodes.add(task.projectCode.toString());
      projectCodes.toSet().toList();
    }
    //toSet() will remove duplicate elements, another way: [...{...suggestions}]
    // print('did i run?');
    // inspect(projectCodes.toSet().toList());
    return projectCodes.toSet().toList();
  }

  @override
  Future<List<String>> getWorkspaces() async {
    List<String> workspaces = [];
    var taskTable = await _database.query(tasksTableName);

    for (var task in taskTable) {
      workspaces.add(task.entries
          .firstWhere((element) => element.key == 'workspaceName')
          .value
          .toString());
    }
    //toSet() will remove duplicate elements, another way: [...{...suggestions}]
    // print('did i run? i am workspaceName');
    // inspect(workspaces.toSet().toList());
    return workspaces.toSet().toList();
  }

  @override
  Future<List<Task>> getFilteredTasks(List<String> parameters) async {
    List<Task> tasks = <Task>[];
    int activity = 1;
    if (parameters[2] == 'active') {
      activity = 1;
    } else if (parameters[2] == 'inactive') {
      activity = 0;
    }
    var tasksTable = await _database.query(
      tasksTableName,
      where: 'projectCode LIKE ? AND workspaceName LIKE ? AND isActive LIKE ?',
      whereArgs: [
        parameters[0] == 'All' ? '%%' : parameters[0],
        parameters[1] == 'All' ? '%%' : parameters[1],
        parameters[2] == 'All' ? '%%' : activity,
      ],
    );
    for (var task in tasksTable) {
      tasks.add(Task.fromJson(task));
    }
    // inspect(tasks);
    return tasks;
  }

  @override
  Future<bool> isProjectActive(String projectCode) async {
    var tasks = await getFilteredTasks([projectCode, 'All', 'All']);
    bool isActive = false;
    for (var task in tasks) {
      if (task.isActive == 1) {
        isActive = true;
        break;
      }
    }
    return isActive;
  }

  @override
  Future<bool> exportTasks() async {
    List<Task> tasks = await getAllTasks();
    List<Map<String, Object?>> tempTasks = [];
    List<List<dynamic>> csvTasks = [];
    List<String> headers = [];
    List<Object?> values = [];

    for (var task in tasks) {
      tempTasks.add(task.toJson());
    }
    for (var task in tempTasks) {
      if (tempTasks.first == task) {
        headers = task.keys.toList();
        csvTasks.add(headers);
      }
      csvTasks.add(task.values.toList());
    }
    var docDir = await getExternalStorageDirectory();
    var csv = const ListToCsvConverter().convert(csvTasks);
    print('this is the csv');
    print(csv);
    File csvFile =
        File('${docDir!.path}/tasks_${DateTime.now().toString()}.csv');
    try {
      await csvFile.writeAsString(csv);
      return true;
    } catch (e) {
      rethrow;
    }
    // return true;
  }

  @override
  Future<bool> importTasks() async {
    List<List<dynamic>> csvTasks = [];
    List<String> headers = [];
    Task newTask = Task();

    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowedExtensions: ['csv'], type: FileType.custom);
    if (result != null) {
      File file = File(result.files.single.path!);
      csvTasks = const CsvToListConverter().convert(await file.readAsString());
      // print('this is my imported big file');
      // inspect(csvTasks);
      for (var task in csvTasks) {
        if (task.first == 'id') {
          continue;
        } else {
          newTask.id = task[0];
          newTask.projectCode = task[1];
          newTask.isActive = task[2];
          newTask.status = task[3];
          newTask.timesPracticed = task[4];
          newTask.lastPracticed = task[5];
          newTask.nextDate = task[6];
          newTask.eFactor = task[7];
          newTask.interval = task[8];
          newTask.reviewDates = task[9];
          await addNewTask(newTask);
        }
      }
      return true;
    } else {
      // User canceled the picker
      return false;
    }
  }

  @override
  Future<List<Task>> filterTasksByTitle(String value) async {
    List<Task> tasks = <Task>[];
    var tasksTable = await _database.query(
      tasksTableName,
      where: 'task LIKE ?',
      whereArgs: ['%$value%'],
    );
    for (var task in tasksTable) {
      tasks.add(Task.fromJson(task));
    }
    // inspect(tasks);
    return tasks;
  }

  @override
  Future<bool> isDuplicate(String value) async {
    List<Task> tasks = <Task>[];
    var tasksTable = await _database.query(
      tasksTableName,
      where: 'projectCode = ?',
      whereArgs: ['value'],
    );
    for (var task in tasksTable) {
      tasks.add(Task.fromJson(task));
    }
    // inspect(tasks);
    if (tasks.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<int> getLatestEntryForProjectCode(String value) async {
    List<Task> tasks = <Task>[];
    var tasksTable = await _database.query(
      tasksTableName,
      where: 'projectCode = ?  AND entry = ?',
      whereArgs: ['value', '(select max(entry) from $tasksTableName)'],
    );
    for (var task in tasksTable) {
      tasks.add(Task.fromJson(task));
    }
    int entry = tasks.first.entry;
    return entry;
  }
}

// 'CREATE TABLE tasks(id TEXT PRIMARY KEY, projectName TEXT, projectCode TEXT, task TEXT, details TEXT, workspaceName TEXT, isActive INTEGER, status INTEGER, timesPracticed INTEGER, lastPracticed TEXT, nextDate TEXT, eFactor REAL, interval INTEGER, reviewDates TEXT)'
