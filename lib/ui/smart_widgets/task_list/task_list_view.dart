import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'task_list_viewmodel.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskListViewModel>.reactive(
      // disposeViewModel: false,
      // initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white10,
          appBar: AppBar(
            title: Text(type),
            backgroundColor: Colors.teal[400],
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.help_outline_rounded),
                onPressed: () {
                  model.navigateToHelpPage();
                },
              ),
              IconButton(
                  onPressed: () {
                    model.showFilterDialog();
                  },
                  icon: const Icon(Icons.filter_alt_outlined)),
            ],
          ),
          body: model.isBusy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  // key: PageStorageKey('storage-key'),
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            decorationColor: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'search...',
                          // icon: const Icon(Icons.search),
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              borderSide: const BorderSide(
                                  color: Colors.teal,
                                  width: 5.0,
                                  style: BorderStyle.solid)),
                          isDense: false,
                          contentPadding: const EdgeInsets.all(8),
                          fillColor: Colors.teal,
                          filled: true,
                        ),
                        onChanged: (value) {
                          model.findTasksBy(value);
                        },
                      ),
                    ),
                    model.tasks.isNotEmpty
                        ? Expanded(
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 8,
                                    ),
                                itemCount: model.tasks.length,
                                itemBuilder: (context, index) => Card(
                                      elevation: 8.0,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 6.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color:
                                                Color.fromRGBO(64, 75, 96, .9)),
                                        child: ListTile(
                                          enableFeedback: true,
                                          horizontalTitleGap: 0,
                                          onTap: () {
                                            model.navigateToDetailsPage(
                                                model.tasks[index].id);
                                          },
                                          onLongPress: () {
                                            model.showCustomBottomSheet(
                                                model.tasks[index]);
                                          },
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20.0,
                                                  vertical: 10.0),
                                          leading: Container(
                                            width: 5,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                color: model.getStatusColor(
                                                    model.tasks[index].status),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: model
                                                        .getStatusColor(model
                                                            .tasks[index]
                                                            .status)
                                                        .withAlpha(60),
                                                    blurRadius: 6.0,
                                                    spreadRadius: 5.0,
                                                    offset: const Offset(
                                                      0.0,
                                                      3.0,
                                                    ),
                                                  ),
                                                ]),
                                            margin: const EdgeInsets.all(0),
                                            padding: const EdgeInsets.all(0),
                                          ),
                                          title: Text(
                                            model.tasks[index].id,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          subtitle: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                    model.tasks[index]
                                                        .projectCode,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white)),
                                                Text(
                                                    model.getScheduleDate(model
                                                        .tasks[index].nextDate),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: DateTime.tryParse(model
                                                                    .tasks[
                                                                        index]
                                                                    .nextDate)!
                                                                .isAfter(
                                                                    DateTime
                                                                        .now())
                                                            ? Colors.white
                                                            : Colors.red)),
                                                Text(
                                                    model.tasks[index]
                                                                .isActive ==
                                                            0
                                                        ? 'INACTIVE'
                                                        : 'ACTIVE',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: model
                                                                    .tasks[
                                                                        index]
                                                                    .isActive ==
                                                                0
                                                            ? Colors.grey
                                                            : Colors
                                                                .blueAccent)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )))
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text('No tasks found!'),
                                Text('Maybe add a new one?'),
                              ],
                            ),
                          )
                  ],
                )
          // : Container(
          //     color: Colors.red,
          //     alignment: Alignment.center,
          //     child: SizedBox(
          //       height: double.infinity,
          //       width: double.infinity,
          //       child: Text(
          //         model.error.toString(),
          //         textAlign: TextAlign.center,
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ),
          ),
      viewModelBuilder: () => TaskListViewModel(type: type),
    );
  }
}
