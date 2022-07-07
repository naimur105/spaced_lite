import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'details_viewmodel.dart';

class DetailsView extends StatelessWidget {
  final String id;
  const DetailsView({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailsViewModel>.reactive(
      builder: (context, model, child) => model.isBusy
          ? const Center(child: CircularProgressIndicator())
          : WillPopScope(
              onWillPop: () {
                return model.popNavigate();
              },
              child: Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                // floatingActionButton: FloatingActionButton(
                //   child: Icon(Icons.edit),
                //   onPressed: () {
                //     model.navigateToEditPage(model.task.id);
                //   },
                // ),
                appBar: AppBar(
                  title: Text('Details'),
                  backgroundColor: Colors.teal[400],
                  actions: [
                    IconButton(
                      onPressed: () {
                        model.deleteTask();
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ],
                ),
                body: ListView(
                  children: <Widget>[
                    Card(
                        color: Colors.blueGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Text("Task:",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          model.toggleActivityOfTask();
                                        },
                                        child: Text(model.task.isActive == 0
                                            ? 'Activate'
                                            : 'Deactivate')),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ]),
                        )),
                    Card(
                        color: Colors.blueGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text("Details:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                              ]),
                        )),
                    Card(
                        color: Colors.blueGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text("Project:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                              ]),
                        )),
                    Card(
                        color: Colors.blueGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text("Project Code:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(model.task.projectCode,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ]),
                        )),
                    Card(
                        color: Colors.blueGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text("Times Practiced:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(model.task.timesPracticed.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ]),
                        )),
                    Card(
                        color: Colors.blueGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text("Scheduled On:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(model.getNextDate(model.data!.nextDate),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ]),
                        )),
                    const SizedBox(height: 100),
                  ],
                ),

                // Container(
                //   decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                //   child: Column(
                //     children: [
                //       Container(
                //         margin: EdgeInsets.all(8),
                //         padding: EdgeInsets.all(8),
                //         child: Column(
                //           children: [
                //             Row(
                //               children: <Widget>[
                //                 Expanded(
                //                     flex: 2,
                //                     child: Icon(
                //                       Icons.flag_rounded,
                //                       size: 24,
                //                       color: model.getStatusColor(model.data!.status),
                //                     )),
                //                 Expanded(flex: 2, child: Text('${model.getWhen()}')),
                //                 Expanded(
                //                     flex: 2,
                //                     child: ElevatedButton(
                //                       onPressed: () {},
                //                       child: Card(
                //                         color: model.data!.isActive == 1
                //                             ? Colors.blueAccent
                //                             : Colors.grey,
                //                         child: model.data!.isActive == 1
                //                             ? Text('Active')
                //                             : Text('Inactive'),
                //                       ),
                //                     )),
                //               ],
                //               // Row(),
                //               // Row(),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Container(
                //         padding: EdgeInsets.all(8),
                //         margin: EdgeInsets.all(8),
                //         child:
                //       ),
                //     ],
                //   ),
                // )
              ),
            ),
      viewModelBuilder: () {
        return DetailsViewModel(id: id);
      },
    );
  }
}
