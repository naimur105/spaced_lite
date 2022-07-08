import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'user_input_viewmodel.dart';

class UserInputView extends StatelessWidget {
  final String id;
  const UserInputView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserInputViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.check),
              onPressed: () {
                model.handleForm(context);
              }),
          appBar: AppBar(title: const Text('add new')),
          body: model.isBusy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: model.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text('Workspace:'),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: TypeAheadFormField(
                                    hideOnEmpty: true,
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      controller: model.textEditingControllerWP,
                                    ),
                                    suggestionsCallback: (pattern) {
                                      return model.getSuggestions(
                                          'workspaceName', pattern);
                                    },
                                    itemBuilder: (context, String suggestion) {
                                      return ListTile(
                                        title: Text(suggestion),
                                      );
                                    },
                                    transitionBuilder:
                                        (context, suggestionsBox, controller) {
                                      return suggestionsBox;
                                    },
                                    onSuggestionSelected: (String suggestion) {
                                      model.setTextEditingControllerWP(
                                          suggestion);
                                    },
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    onSaved: (String? value) {
                                      model.task.workspaceName = value!;
                                    },
                                  ),
                                ),
                                const Text('Project code:'),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: TypeAheadFormField(
                                    hideOnEmpty: true,
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      controller: model.textEditingControllerPC,
                                    ),
                                    suggestionsCallback: (pattern) {
                                      return model.getSuggestions(
                                          'projectCode', pattern);
                                    },
                                    itemBuilder: (context, String suggestion) {
                                      return ListTile(
                                        title: Text(suggestion),
                                      );
                                    },
                                    transitionBuilder:
                                        (context, suggestionsBox, controller) {
                                      return suggestionsBox;
                                    },
                                    onSuggestionSelected: (String suggestion) {
                                      model.setTextEditingControllerPC(
                                          suggestion);
                                    },
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      } else if (value.length < 6) {
                                        return 'must be atleast 6 characters long';
                                      }
                                      return null;
                                    },
                                    onSaved: (String? value) {
                                      model.task.projectCode = value!;
                                    },
                                  ),
                                ),
                                Card(
                                  child: model.getSuffixText(),
                                ),
                                Card(
                                  child: Text(
                                      '${model.textEditingControllerPC.text.toUpperCase()}-${model.getSuffix(model.entry)}'),
                                ),
                                model.copies > 1
                                    ? Card(
                                        child: Text(
                                            'to  ${model.textEditingControllerPC.text.toUpperCase()}-${model.getSuffix(model.entry + model.copies - 1)}'),
                                      )
                                    : SizedBox(
                                        width: 1,
                                        height: 1,
                                      ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            model.incrementCopies();
                                          },
                                          icon: Icon(CupertinoIcons.up_arrow)),
                                      Card(
                                        child: Text('copies: ${model.copies}'),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            model.decrementCopies();
                                          },
                                          icon:
                                              Icon(CupertinoIcons.down_arrow)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 200),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
      viewModelBuilder: () => UserInputViewModel(id: id),
    );
  }
}
