import 'package:stacked/stacked_annotations.dart';
import 'package:spaced_lite/services/api/api.dart';
import 'package:spaced_lite/services/api/fake_api.dart';
import 'package:spaced_lite/services/api/sqlite_api.dart';
import 'package:spaced_lite/ui/views/add_task/add_task_view.dart';
import 'package:spaced_lite/ui/views/details/details_view.dart';
import 'package:spaced_lite/ui/views/help/help_view.dart';
import 'package:spaced_lite/ui/views/home/home_view.dart';
import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/stacked_services.dart';
// import 'package:stacked_themes/stacked_themes.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
    CupertinoRoute(page: AddTaskView),
    CupertinoRoute(page: DetailsView),
    CupertinoRoute(page: HelpView),
  ],
  dependencies: [
    Singleton(classType: NavigationService),
    // Singleton(classType: ThemeService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SqliteApi, asType: Api),
    LazySingleton(classType: DialogService),
  ],
  logger: StackedLogger(),
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
