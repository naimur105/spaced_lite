import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/src/shared/ui_helpers.dart';
import 'package:spaced_lite/src/widgets/box_text.dart';
import 'package:stacked_services/stacked_services.dart';
import 'filter_dialog_content_viewmodel.dart';

class FilterDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const FilterDialog({Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child:
            _FilterDialogContentView(request: request, completer: completer));
  }
}

class _FilterDialogContentView extends StatelessWidget {
  const _FilterDialogContentView(
      {Key? key, required this.request, required this.completer})
      : super(key: key);
  final DialogRequest request;
  final Function(DialogResponse dialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterDialogContentViewModel>.reactive(
      builder: (context, model, child) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: screenWidthPercentage(context, percentage: 0.001),
            ),
            padding: const EdgeInsets.only(
              top: 12,
              left: 16,
              right: 16,
              bottom: 12,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(64, 75, 96, .9),
              borderRadius: BorderRadius.circular(24),
            ),
            child: model.isBusy
                ? const Center(
                    heightFactor: 10,
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      verticalSpaceSmall,
                      BoxText.subheading(
                        request.title ?? '',
                        align: TextAlign.center,
                      ),
                      verticalSpaceSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('by project(code):'),
                          DropdownButton<String>(
                            dropdownColor: const Color.fromRGBO(64, 75, 96, .9),
                            value: model.projectCodeValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.white),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              model.setProjectCodeValue(newValue);
                            },
                            items: model.projectCodes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('by workspace:'),
                          DropdownButton<String>(
                            dropdownColor: Color.fromRGBO(64, 75, 96, .9),
                            value: model.workspaceValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.white),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              model.setWorkspaceValue(newValue);
                            },
                            items: model.workspaces
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('by activity:'),
                          DropdownButton<String>(
                            dropdownColor: const Color.fromRGBO(64, 75, 96, .9),
                            value: model.activityValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.white),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              model.setActivityValue(newValue);
                            },
                            items: model.activities
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      verticalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (request.secondaryButtonTitle != null)
                            TextButton(
                              onPressed: () =>
                                  completer(DialogResponse(confirmed: false)),
                              child: BoxText.body(
                                request.secondaryButtonTitle!,
                                color: Colors.grey,
                              ),
                            ),
                          TextButton(
                            onPressed: () => completer(DialogResponse(
                              confirmed: true,
                              data: [
                                model.projectCodeValue,
                                model.workspaceValue,
                                model.activityValue
                              ],
                            )),
                            child: BoxText.body(
                              request.mainButtonTitle ?? '',
                              color: Colors.amber[900]!,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
      viewModelBuilder: () => FilterDialogContentViewModel(),
    );
  }
}
