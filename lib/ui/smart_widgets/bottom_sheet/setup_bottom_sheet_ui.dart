import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:spaced_lite/enums/bottom_sheet_type.dart';
import 'floating_box_bottom_sheet_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();
  final builders = {
    BottomSheetType.floating: (context, sheetRequest, completer) =>
        _FloatingBoxBottomSheet(request: sheetRequest, completer: completer)
  };
  bottomSheetService.setCustomSheetBuilders(builders);
}

class _FloatingBoxBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;
  const _FloatingBoxBottomSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FloatingBoxBottomSheetViewModel>.reactive(
      onModelReady: (model) {
        model.prepareSchedulefor(request.data!);
      },
      builder: (context, model, child) {
        return Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  request.title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  request.description!,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                focusColor: Colors.red,
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                onTap: () {
                  model.updateTask(5);
                  completer(SheetResponse(confirmed: true));
                },
                leading: Icon(
                  Icons.emoji_emotions,
                  color: Colors.blueAccent[700],
                ),
                title: const Text(
                  'Excellent',
                  // style: TextStyle(color: Theme.of(context).primaryColor),
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text('+${model.intervalMap[5]}d'),
              ),
              ListTile(
                focusColor: Colors.red,
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                onTap: () {
                  model.updateTask(4);
                  completer(SheetResponse(confirmed: true));
                },
                leading: Icon(
                  Icons.emoji_emotions,
                  color: Colors.blueAccent,
                ),
                title: const Text(
                  'Correct A',
                  // style: TextStyle(color: Theme.of(context).primaryColor),
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text('+${model.intervalMap[4]}d'),
              ),
              ListTile(
                focusColor: Colors.red,
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                onTap: () {
                  model.updateTask(3);
                  completer(SheetResponse(confirmed: true));
                },
                leading: Icon(
                  Icons.emoji_emotions,
                  color: Colors.green,
                ),
                title: const Text(
                  'Correct B',
                  // style: TextStyle(color: Theme.of(context).primaryColor),
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text('+${model.intervalMap[3]}d'),
              ),
              ListTile(
                focusColor: Colors.red,
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                onTap: () {
                  model.updateTask(2);
                  completer(SheetResponse(confirmed: true));
                },
                leading: Icon(
                  Icons.emoji_emotions,
                  color: Colors.yellowAccent,
                ),
                title: const Text(
                  'Error A',
                  // style: TextStyle(color: Theme.of(context).primaryColor),
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text('+${model.intervalMap[2]}d'),
              ),
              ListTile(
                focusColor: Colors.red,
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                onTap: () {
                  model.updateTask(1);
                  completer(SheetResponse(confirmed: true));
                },
                leading: Icon(
                  Icons.emoji_emotions,
                  color: Colors.orange[600],
                ),
                title: const Text(
                  'Error B',
                  // style: TextStyle(color: Theme.of(context).primaryColor),
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text('+${model.intervalMap[1]}d'),
              ),
              ListTile(
                focusColor: Colors.red,
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                onTap: () {
                  model.updateTask(0);
                  completer(SheetResponse(confirmed: true));
                },
                leading: Icon(
                  Icons.emoji_emotions,
                  color: Colors.deepOrangeAccent[700],
                ),
                title: const Text(
                  'Blackout!',
                  // style: TextStyle(color: Theme.of(context).primaryColor),
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text('+${model.intervalMap[0]}d'),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => FloatingBoxBottomSheetViewModel(),
    );
  }
}
