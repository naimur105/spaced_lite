import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/ui/smart_widgets/task_list/task_list_view.dart';
import 'package:spaced_lite/ui/views/tasks_today/tasks_today_viewmodel.dart';

class TasksTodayView extends StatelessWidget {
  const TasksTodayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TasksTodayViewModel>.reactive(
      // disposeViewModel: false,
      // initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => TaskListView(type: 'today'),
      viewModelBuilder: () => TasksTodayViewModel(),
      // onModelReady: (model) => model.initialize(),
    );
  }
}
