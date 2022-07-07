import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/ui/views/search_bar/search_bar_viewmodel.dart';

class SearchBarView extends StatelessWidget {
  const SearchBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchBarViewModel>.reactive(
      builder: (context, model, child) => AppBar(
        leading: model.isSearching ? const BackButton() : Container(),
        title: model.isSearching ? model.buildSearchField() : const Text('All'),
        actions: model.buildActions(),
      ),
      viewModelBuilder: () => SearchBarViewModel(),
    );
  }
}
