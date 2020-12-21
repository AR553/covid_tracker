import 'package:rxdart/rxdart.dart';

class SearchInputBloc {
  final _searchInputFetcher = BehaviorSubject<String>();

  void updateSearchInput(String input) {
    _searchInputFetcher.add(input);
    // print(input);
  }

  Stream<String> get searchInput => _searchInputFetcher.stream;

  dispose() {
    _searchInputFetcher.close();
  }
}
