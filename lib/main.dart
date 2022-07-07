import 'dart:io';
import 'package:flutter/material.dart';
import 'package:spaced_lite/services/api/api.dart';
import 'package:spaced_lite/ui/shared/setup_dialog_ui.dart';
import 'package:spaced_lite/ui/smart_widgets/bottom_sheet/setup_bottom_sheet_ui.dart';
import 'package:spaced_lite/ui/views/home/home_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app.locator.dart';
import 'app/app.router.dart';

Future main() async {
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'spaced_lite',
      theme: ThemeData(
        primaryTextTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          button: TextStyle(color: Colors.white),
          caption: TextStyle(color: Colors.white),
          headline1: TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border:
              UnderlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          isDense: false,
          contentPadding: const EdgeInsets.all(8),
          fillColor: Colors.green[100],
          filled: true,
        ),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.amber[900]),
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          button: TextStyle(color: Colors.white),
          caption: TextStyle(color: Colors.white),
          headline1: TextStyle(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.white24,
        cardColor: const Color.fromRGBO(64, 75, 96, .9),
        backgroundColor: Colors.white10,
        cardTheme: const CardTheme(
          color: Color.fromRGBO(64, 75, 96, .9),
          margin: EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: 8,
            right: 8,
          ),
          elevation: 8,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.green,
        ),
        buttonTheme: ButtonThemeData(buttonColor: Colors.amber[900]),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.teal[400],
          selectedItemColor: Colors.white,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
        ),
        primarySwatch: Colors.teal,
      ),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      home: const HomeView(),
    );
  }
}
