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
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: IconButton(
                                            iconSize: 40,
                                            onPressed: () {
                                              model.incrementCopies();
                                            },
                                            icon: Icon(Icons.add),
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blueGrey,
                                          gradient: const LinearGradient(
                                              colors: [
                                                Colors.amber,
                                                Colors.red
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight),
                                          // boxShadow: const [
                                          //   BoxShadow(
                                          //     color: Colors.red,
                                          //     offset: Offset(10, 20),
                                          //     blurRadius: 30,
                                          //   )
                                          // ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${model.copies}',
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'copies',
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      // Card(
                                      //   child: Text('copies: ${model.copies}'),
                                      // ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: IconButton(
                                            iconSize: 40,
                                            onPressed: () {
                                              model.decrementCopies();
                                            },
                                            icon: Icon(Icons.remove),
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // Card(
                                      //   child: model.getSuffixText(),
                                      // ),
                                      // Card(
                                      //   child: Text(
                                      //       '${model.textEditingControllerPC.text.toUpperCase()}-${model.getSuffix(model.entry)}'),
                                      // ),
                                      model.copies > 1
                                          ? Text(
                                              '${model.textEditingControllerPC.text.toUpperCase()}-${model.getSuffix(model.entry)} to ${model.textEditingControllerPC.text.toUpperCase()}-${model.getSuffix(model.entry + model.copies - 1)}',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : Text(
                                              '${model.textEditingControllerPC.text.toUpperCase()}-${model.getSuffix(model.entry)}',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400),
                                            ),
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
