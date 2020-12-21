import 'dart:async';

import 'package:zero_to_hero/src/models/countries_item_model.dart';
import 'package:zero_to_hero/src/models/date_item_model.dart';
import 'package:zero_to_hero/src/models/timeline_item_model.dart';
import 'covid_api_provider.dart';

class Repository {
  final covidApiProvider = CovidApiProvider();

  Future<List<CountryItemModel>> fetchCountry() =>
      covidApiProvider.fetchCountry();

  Future<DateItemModel> fetchTotal() => covidApiProvider.fetchTotal();

  Future<DateItemModel> fetchToday() => covidApiProvider.fetchToday();

  Future<DateItemModel> fetchYesterday() => covidApiProvider.fetchYesterday();

  Future<List<TimelineItemModel>> fetchTimeline() =>
      covidApiProvider.fetchTimeline();
}
