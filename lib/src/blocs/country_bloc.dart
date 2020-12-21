import 'package:zero_to_hero/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zero_to_hero/src/models/countries_item_model.dart';

class CountryBloc {
  final _repository = Repository();
  List<CountryItemModel> finalCountries;
  final _countriesFetcher = BehaviorSubject<List<CountryItemModel>>();
  CountryBloc() {
    _fetchCountry();
  }

  void updateSearchInput(String searchInput) {
    List<CountryItemModel> searchedCountries = [];
    searchedCountries.addAll(finalCountries);
    searchedCountries.retainWhere((element) =>
        element.country.toLowerCase().contains(searchInput.toLowerCase()));
    _countriesFetcher.add(searchedCountries);
  }

  Stream<List<CountryItemModel>> get countries {
    return _countriesFetcher.stream;
  }

  void _fetchCountry() async {
    finalCountries = await _repository.fetchCountry();
    _countriesFetcher.add(finalCountries);
  }

  dispose() {
    _countriesFetcher.close();
  }
}
