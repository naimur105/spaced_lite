import 'package:flutter/material.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:spaced_lite/enums/dialog_type.dart';
import 'package:spaced_lite/ui/shared/dialogs/basic_dialog.dart';
import 'package:spaced_lite/ui/shared/dialogs/filter_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  var dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (BuildContext context, DialogRequest request,
            Function(DialogResponse) completer) =>
        BasicDialog(request: request, completer: completer),
    DialogType.filter: (BuildContext context, DialogRequest request,
            Function(DialogResponse) completer) =>
        FilterDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
