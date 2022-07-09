// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/ui/smart_widgets/bar_chart/bar_chart_view.dart';
import 'package:spaced_lite/ui/smart_widgets/pie_chart/pie_chart_view.dart';
// import 'package:spaced_lite/ui/smart_widgets/projects/projects_view.dart';
import 'package:spaced_lite/ui/views/profile/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            backgroundColor: Colors.teal[400],
          ),
          body: model.isBusy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    const PieChartView(),
                    const BarChartView(),
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                model.exportTasks();
                              },
                              child: const Text('export as csv')),
                          IconButton(
                            onPressed: () {
                              model.notifyListeners();
                            },
                            icon: const Icon(Icons.refresh_sharp),
                            color: Colors.amber[900],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                model.importTasks();
                              },
                              child: const Text('import csv')),
                        ],
                      ),
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: model.projects.length,
                        itemBuilder: (context, index) => Card(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(64, 75, 96, .9)),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  title: Text(
                                    model.projects[index].projectCode,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  // subtitle: Text(
                                  //     model.projects[index].projectCode,
                                  //     style: const TextStyle(
                                  //         fontSize: 16, color: Colors.white)),

                                  trailing: Switch(
                                      value: model.projects[index].isActive,
                                      onChanged: (bool newValue) {
                                        model.toggleProjectActivity(
                                            model.projects[index], newValue);
                                      }),
                                ),
                              ),
                            )),
                  ],
                )),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
