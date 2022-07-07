import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/ui/views/profile/profile_view.dart';
import 'package:spaced_lite/ui/views/tasks_all/tasks_all_view.dart';
import 'package:spaced_lite/ui/views/tasks_today/tasks_today_view.dart';
import 'package:spaced_lite/ui/views/test_screen/test_screen_view.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white10,
        body: getViewForIndex(model.currentIndex),
        floatingActionButton: FloatingActionButton(
          onPressed: model.addNewTask,
          child: Icon(Icons.add, size: 40),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 28,
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.today_outlined),
              label: 'today',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_outlined), label: 'all'),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                // size: 0,
                color: Colors.transparent,
              ),
              label: 'add new',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined), label: 'profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'settings'),
          ],
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return TasksTodayView();
      case 1:
        return TasksAllView();
      case 3:
        return ProfileView();
      case 4:
        return const Center(
          child: Text('under construction'),
        );
      default:
        return TasksTodayView();
    }
  }
}
