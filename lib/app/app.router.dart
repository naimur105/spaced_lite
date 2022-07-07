// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/views/add_task/add_task_view.dart';
import '../ui/views/details/details_view.dart';
import '../ui/views/help/help_view.dart';
import '../ui/views/home/home_view.dart';

class Routes {
  static const String homeView = '/';
  static const String addTaskView = '/add-task-view';
  static const String detailsView = '/details-view';
  static const String editTaskView = '/edit-task-view';
  static const String helpView = '/help-view';
  static const all = <String>{
    homeView,
    addTaskView,
    detailsView,
    editTaskView,
    helpView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.addTaskView, page: AddTaskView),
    RouteDef(Routes.detailsView, page: DetailsView),
    RouteDef(Routes.helpView, page: HelpView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    AddTaskView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const AddTaskView(),
        settings: data,
      );
    },
    DetailsView: (data) {
      var args = data.getArgs<DetailsViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => DetailsView(
          key: args.key,
          id: args.id,
        ),
        settings: data,
      );
    },
    HelpView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const HelpView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// DetailsView arguments holder class
class DetailsViewArguments {
  final Key? key;
  final String id;
  DetailsViewArguments({this.key, required this.id});
}

/// EditTaskView arguments holder class
class EditTaskViewArguments {
  final Key? key;
  final String id;
  EditTaskViewArguments({this.key, required this.id});
}
