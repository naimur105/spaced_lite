import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'bar_chart_viewmodel.dart';

class BarChartView extends StatelessWidget {
  const BarChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BarChartViewModel>.reactive(
      builder: (context, model, child) => model.isBusy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Performance in:'),
                    DropdownButton<String>(
                      dropdownColor: const Color.fromRGBO(64, 75, 96, .9),
                      value: model.workspaceValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        model.setWorkspaceValue(newValue);
                      },
                      items: model.workspaces
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                AspectRatio(
                  aspectRatio: 1.66,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    // color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.center,
                          barTouchData: BarTouchData(
                            enabled: false,
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 28,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text(
                                      model.projectCodes[value.toInt()],
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                              ),
                              // showTitles: true,
                              // getTextStyles: (context, value) =>
                              //     const TextStyle(
                              //         color: Colors.white, fontSize: 10),
                              // margin: 5,
                              // sideTitles: (double value) {
                              //   return model.projectCodes[value.toInt()];
                              // },
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 34,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text(
                                      '${value.toInt()}%',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                              ),
                              // getTitles: (double value) {
                              //   return '$value%';
                              // },
                              // showTitles: true,
                              // reservedSize: 40,
                              // getTextStyles: (context, value) =>
                              //     const TextStyle(
                              //         color: Colors.white, fontSize: 10),
                              // margin: 0,
                            ),
                            topTitles: AxisTitles(),
                            rightTitles: AxisTitles(),
                          ),
                          gridData: FlGridData(
                            show: true,
                            checkToShowHorizontalLine: (value) =>
                                value % 10 == 0,
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: const Color(0xffe7e8ec),
                              strokeWidth: 1,
                            ),
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          groupsSpace: 20,
                          barGroups: model.barChartGroups.entries
                              .firstWhere((element) =>
                                  element.key == model.workspaceValue)
                              .value,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      viewModelBuilder: () => BarChartViewModel(),
    );
  }
}
