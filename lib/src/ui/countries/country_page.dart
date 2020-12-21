import 'package:flutter/material.dart';
import 'package:zero_to_hero/src/blocs/country_bloc.dart';
import 'package:zero_to_hero/src/models/countries_item_model.dart';
import 'package:zero_to_hero/src/ui/clear_app_bar.dart';
import 'package:zero_to_hero/src/ui/countries/countries.dart';
import 'package:zero_to_hero/src/ui/dimens.dart';
import 'package:zero_to_hero/src/ui/global_stats/plain_scroll_behavior.dart';
import 'package:zero_to_hero/src/ui/strings.dart';

import 'country_list_tile.dart';
import 'search_bar.dart';

class CountryPage extends StatefulWidget {
  CountryPage({this.countryBloc});
  final CountryBloc countryBloc;
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(
                  Dimens.RADIUS_L,
                ),
              ),
            ),
            child: Column(
              children: [
                ClearAppBar(
                  title: Text(
                    Strings.COUNTRIES,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Dimens.INSET_S,
                    bottom: Dimens.INSET_S,
                    right: Dimens.INSET_S,
                  ),
                  child: SearchBar(
                    countryBloc: widget.countryBloc,
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
              stream: widget.countryBloc.countries,
              builder:
                  (context, AsyncSnapshot<List<CountryItemModel>> snapshot) =>
                      buildList(snapshot)),
        ],
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<CountryItemModel>> snapshot) {
    if (snapshot.hasData) {
      return getList(snapshot.data);
    } else if (snapshot.hasError)
      return Text(snapshot.error.toString());
    else
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
  }

  Expanded getList(List<CountryItemModel> list) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: PlainScrollBehavior(),
        child: ListView.builder(
          padding: EdgeInsets.all(
            Dimens.INSET_S,
          ),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            final int severity = index % 3;
            String name = kCountries[list[index].country] != null
                ? kCountries[list[index].country]
                : list[index].country;
            // if (name.length < 3)
            // print(name + " ${snapshot.data.results[index].cases}");
            return CountryListTile(
              country: name.length > 20 ? name.substring(0, 18) + ".." : name,
              severity: Severity.values[severity],
              cases: list[index].cases,
            );
          },
        ),
      ),
    );
  }
}
