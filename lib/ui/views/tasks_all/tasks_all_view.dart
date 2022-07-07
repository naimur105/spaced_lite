import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/ui/smart_widgets/task_list/task_list_view.dart';
import 'package:spaced_lite/ui/views/tasks_all/tasks_all_viewmodel.dart';

class TasksAllView extends StatelessWidget {
  const TasksAllView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TasksAllViewModel>.reactive(
      builder: (context, model, child) => TaskListView(type: 'all'),
      viewModelBuilder: () => TasksAllViewModel(),
    );
  }
}
