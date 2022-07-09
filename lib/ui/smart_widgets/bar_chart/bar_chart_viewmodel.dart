import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:spaced_lite/datamodels/api_models.dart';
import 'package:spaced_lite/services/api/api.dart';

class BarChartViewModel extends FutureViewModel {
  String workspaceValue = 'One';
  List<String> workspaces = ['these', 'shouldn\'t', 'be', 'here'];
  void setWorkspaceValue(String? newValue) {
    workspaceValue = newValue!;
    notifyListeners();
  }

  final _api = locator<Api>();
  List<Task> tasks = [];
  List<String> projectCodes = [];
  List<BarChartGroupData> barChartData = [];
  var barChartGroups = <String, List<BarChartGroupData>>{};

  final Color excellent_color = Colors.blueAccent[700]!;
  final Color correctA_color = Colors.blueAccent;
  final Color correctB_color = Colors.green;
  final Color errorA_color = Colors.yellowAccent;
  final Color errorB_color = Colors.orange[600]!;
  final Color blackout_color = Colors.deepOrangeAccent[700]!;

  double excellent = 0;
  double correctA = 0;
  double correctB = 0;
  double errorA = 0;
  double errorB = 0;
  double blackout = 0;
  double total = 0;
  double value = 0;

  @override
  Future futureToRun() async {
    barChartData.clear();
    // workspaces = await _api.getWorkspaces();
    workspaceValue = 'All';
    projectCodes = await _api.getProjectCodes(workspace: 'All');
    // for (var workspace in workspaces) {
    // }
    barChartGroups['All'] = await getData('All');
    // projectCode, workspace, isActive
    // List<Task> tasks = await _api
    //     .getFilteredTasks(['$projectCodes[0]', workspaceValue, 'active']);
  }

  Future<List<BarChartGroupData>> getData(String workspace) async {
    for (var projectCode in projectCodes) {
      List<Task> tasks =
          await _api.getFilteredTasks([projectCode, workspace, 'active']);
      excellent = 0;
      correctA = 0;
      correctB = 0;
      errorA = 0;
      errorB = 0;
      blackout = 0;
      total = 0;
      int status = 0;
      for (var task in tasks) {
        status = task.status;
        if (status == 0) {
          blackout++;
        } else if (status == 1) {
          errorB++;
        } else if (status == 2) {
          errorA++;
        } else if (status == 3) {
          correctB++;
        } else if (status == 4) {
          correctA++;
        } else if (status == 5) {
          excellent++;
        }
      }
      total = blackout + errorB + errorA + correctB + correctA + excellent;
      value = total - blackout;
      double yValue = (value * 100) / total;
      // print(
      //     'the last value is${(100 / yValue) * (excellent + correctA + correctB + errorA + errorB)}');
      // print(
      //     'the value is $yValue. e: $excellent, ca: $correctA, cb: $correctB, ea: $errorA, eb: $errorB');
      // print("${(errorB * 100) / yValue}");
      barChartData.add(BarChartGroupData(
          x: projectCodes.indexOf(projectCode),
          barsSpace: 5,
          barRods: [
            BarChartRodData(
                width: 20,
                toY: yValue,
                rodStackItems: [
                  //excellent
                  BarChartRodStackItem(
                      0, (excellent * yValue) / value, excellent_color),
                  //correctA
                  BarChartRodStackItem(
                      (excellent * yValue) / value,
                      (yValue / value) * (excellent + correctA),
                      correctA_color),
                  //correctB
                  BarChartRodStackItem(
                      (yValue / value) * (excellent + correctA),
                      (yValue / value) * (excellent + correctA + correctB),
                      correctB_color),
                  //errorA
                  BarChartRodStackItem(
                      (yValue / value) * (excellent + correctA + correctB),
                      (yValue / value) *
                          (excellent + correctA + correctB + errorA),
                      errorA_color),
                  //errorB
                  BarChartRodStackItem(
                      (yValue / value) *
                          (excellent + correctA + correctB + errorA),
                      (yValue / value) *
                          (excellent + correctA + correctB + errorA + errorB),
                      errorB_color),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(5))),
          ]));
    }
    return barChartData;
  }
}
