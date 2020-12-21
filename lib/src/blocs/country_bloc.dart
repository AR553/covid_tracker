import 'package:zero_to_hero/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zero_to_hero/src/models/countries_item_model.dart';

class CountryBloc {
  final _repository = Repository();
  final _countryFetcher = BehaviorSubject<CountriesItemModel>();
  CountryBloc() {
    // fetch once
    _fetchCountry();
  }

  Stream<CountriesItemModel> get country => _countryFetcher.stream;

  void _fetchCountry() async {
    CountriesItemModel countryItemModel = await _repository.fetchCountry();
    _countryFetcher.add(countryItemModel);
  }

  dispose() {
    _countryFetcher.close();
  }
}
