import 'package:zero_to_hero/src/ui/countries/countries.dart';

class CountriesItemModel {
  List<CountryItemModel> _countries = [];

  CountriesItemModel.fromJson(List<dynamic> parsedJson) {
    // print(parsedJson.length);
    List<CountryItemModel> temp = [];
    for (int i = 0; i < parsedJson.length; i++) {
      CountryItemModel result = CountryItemModel(parsedJson[i]);
      temp.add(result);
    }
    _countries = temp;
  }

  List<CountryItemModel> get countries => _countries;
}

class CountryItemModel {
  String _country;
// ignore: non_constant_identifier_names
  String _last_update;
  int _cases;
  int _deaths;
  int _recovered;

  CountryItemModel(country) {
    _country = kCountries[country['country']] ?? country['country'];
    _last_update = country['last_update'];
    _cases = country['cases'];
    _deaths = country['deaths'];
    _recovered = country['recovered'];
  }

  String get country => _country;
// ignore: non_constant_identifier_names
  String get last_update => _last_update;
  int get cases => _cases;
  int get deaths => _deaths;
  int get recovered => _recovered;
}
