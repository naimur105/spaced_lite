import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/ui/views/search_bar/search_bar_view.dart';
import 'package:spaced_lite/ui/views/test_screen/test_screen_viewmodel.dart';

class TestScreenView extends StatelessWidget {
  const TestScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TestScreenViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          child: SearchBarView(),
        ),
      ),
      viewModelBuilder: () => TestScreenViewModel(),
    );
  }
}
