import 'package:stacked/stacked.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:spaced_lite/app/app.router.dart';
import 'package:spaced_lite/services/api/api.dart';
import 'package:spaced_lite/ui/views/add_task/add_task_view.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends IndexTrackingViewModel {
  final _navigationService = locator<NavigationService>();

  var navigationResult;
  addNewTask() async {
    navigationResult = await _navigationService.navigateToView(AddTaskView());

    if (navigationResult == 'changed') {
      _navigationService.replaceWith(Routes.homeView);
    }
  }
}
