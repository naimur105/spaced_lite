import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:spaced_lite/datamodels/api_models.dart';
import 'package:spaced_lite/services/api/api.dart';

class PieChartViewModel extends FutureViewModel {
  final _api = locator<Api>();

  int touchedIndex = -1;
  List<PieChartSectionData> dataList = [];
  int excellent = 0;
  int correctA = 0;
  int correctB = 0;
  int errorA = 0;
  int errorB = 0;
  int blackout = 0;
  int total = 0;

  // void changeTouchedIndex(int index) {
  //   touchedIndex = index;
  //   showingSections();
  //   notifyListeners();
  // }

  void responseTouch(FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
    if (!event.isInterestedForInteractions ||
        pieTouchResponse == null ||
        pieTouchResponse.touchedSection == null) {
      touchedIndex = -1;
      notifyListeners();
      return;
    }
    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
    notifyListeners();
  }

  double getPercent(int value) {
    if (value != 0) {
      return ((value * 100) / total);
    } else {
      return 0;
    }
  }

  List<PieChartSectionData> showingSections() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataList = List.generate(6, (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Colors.blueAccent[700],
              value: getPercent(excellent),
              title: excellent.toString(),
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          case 1:
            return PieChartSectionData(
              color: Colors.blueAccent,
              value: getPercent(correctA),
              title: correctA.toString(),
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          case 2:
            return PieChartSectionData(
              color: Colors.green,
              value: getPercent(correctB),
              title: correctB.toString(),
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          case 3:
            return PieChartSectionData(
              color: Colors.yellowAccent,
              value: getPercent(errorA),
              title: errorA.toString(),
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          case 4:
            return PieChartSectionData(
              color: Colors.orange[600],
              value: getPercent(errorB),
              title: errorB.toString(),
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          case 5:
            return PieChartSectionData(
              color: Colors.deepOrangeAccent[700],
              value: getPercent(blackout),
              title: blackout.toString(),
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          default:
            throw Error();
        }
      });
      notifyListeners();
    });
    return dataList;
  }

  @override
  Future futureToRun() async {
    excellent = 0;
    correctA = 0;
    correctB = 0;
    errorA = 0;
    errorB = 0;
    blackout = 0;
    total = 0;
    int status = 0;
    List<Task> tasks = await _api.getFilteredTasks(['All', 'All', 'active']);
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
    // print('total is $total');
  }
}
