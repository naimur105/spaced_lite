import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'help_viewmodel.dart';

class HelpView extends StatelessWidget {
  const HelpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HelpViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Help'),
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
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: const <Widget>[
                            Text(
                              'How does it work?',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                '1. Add a task\n2. Learn it.\n3. Recall\n4. Based on how good you have recalled, give a review (long press a task)\n5. The task will be scheduled for another day automatically and will arrive on \'today\' section'),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: const <Widget>[
                            Text(
                              'The review system',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                '5. Excellent: recalled perfectly\n4. Correct A: recalled correctly with a little difficulty\n3. Correct B: recalled correctly with serious difficulty\n2. Error A: recalled with small error\n1. Error B: Recalled with serious error\n0. Blackout: nothing remembered\ntip: It is better to practice to the point where the response is atleast correct B before giving any lower rating.'),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: const <Widget>[
                            Text(
                              'An example task',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Task title: Nuclear Binding energy, example 4\nDetails(optional): example 4: Determine the binding energy per nucleon in tin-120\nProject name: Reactor Physics 1\nProject code: PHY 413\nWorkspace: L-4 S-1',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
      viewModelBuilder: () => HelpViewModel(),
    );
  }
}
