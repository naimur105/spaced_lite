// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api/api.dart';
import '../services/api/sqlite_api.dart';

final locator = StackedLocator.instance;

setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerSingleton(NavigationService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton<Api>(() => SqliteApi());
  locator.registerLazySingleton(() => DialogService());
}
