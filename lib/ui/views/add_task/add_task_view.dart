import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/ui/smart_widgets/user_input/user_input_view.dart';

import 'add_task_viewmodel.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddTaskViewModel>.reactive(
      builder: (context, model, child) => Container(
        child: UserInputView(
          id: '',
        ),
      ),
      viewModelBuilder: () => AddTaskViewModel(),
    );
  }
}
