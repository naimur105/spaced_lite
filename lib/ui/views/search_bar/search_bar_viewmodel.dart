import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:spaced_lite/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchBarViewModel extends BaseViewModel {
  TextEditingController _searchQueryController = TextEditingController();
  bool isSearching = false;
  String searchQuery = "Search query";
  final _navigationService = locator<NavigationService>();

  void toggleSearchMode() {
    isSearching = !isSearching;
    notifyListeners();
  }

  Widget buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "search...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> buildActions() {
    if (isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              _navigationService.back();
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          _startSearch();
        },
      ),
    ];
  }

  void _startSearch() {
    // ModalRoute.of(context)
    //     .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    isSearching = true;
    notifyListeners();
  }

  void updateSearchQuery(String newQuery) {
    searchQuery = newQuery;
    notifyListeners();
  }

  void _stopSearching() {
    _clearSearchQuery();
    isSearching = false;
    notifyListeners();
  }

  void _clearSearchQuery() {
    _searchQueryController.clear();
    updateSearchQuery("");
    notifyListeners();
  }
}
