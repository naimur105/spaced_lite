import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/ui/helpers/indicator.dart';
import 'package:spaced_lite/ui/smart_widgets/pie_chart/pie_chart_viewmodel.dart';

class PieChartView extends StatelessWidget {
  const PieChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PieChartViewModel>.reactive(
      builder: (context, model, child) => AspectRatio(
          aspectRatio: 1.3,
          child: Card(
              // color: Colors.white,
              child: model.isBusy
                  ? const CircularProgressIndicator()
                  : Row(
                      children: <Widget>[
                        // const SizedBox(
                        //   height: 18,
                        // ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  model.responseTouch(event, pieTouchResponse);
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 40,
                                sections: model.showingSections(),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Indicator(
                              color: Colors.blueAccent[700]!,
                              text: 'Excellent',
                              isSquare: true,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Indicator(
                              color: Colors.blueAccent,
                              text: 'Correct A',
                              isSquare: true,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Indicator(
                              color: Colors.green,
                              text: 'Correct B',
                              isSquare: true,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Indicator(
                              color: Colors.yellowAccent,
                              text: 'Error A',
                              isSquare: true,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Colors.orange[600]!,
                              text: 'Error B',
                              isSquare: true,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Colors.deepOrangeAccent[700]!,
                              text: 'Blackout!',
                              isSquare: true,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 28,
                        ),
                      ],
                    ))),
      viewModelBuilder: () => PieChartViewModel(),
    );
  }
}
