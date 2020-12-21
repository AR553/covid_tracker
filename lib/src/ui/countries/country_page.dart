import 'package:flutter/material.dart';
import 'package:zero_to_hero/src/blocs/country_bloc.dart';
import 'package:zero_to_hero/src/blocs/search_input_bloc.dart';
import 'package:zero_to_hero/src/models/countries_item_model.dart';
import 'package:zero_to_hero/src/ui/clear_app_bar.dart';
import 'package:zero_to_hero/src/ui/countries/countries.dart';
import 'package:zero_to_hero/src/ui/dimens.dart';
import 'package:zero_to_hero/src/ui/global_stats/plain_scroll_behavior.dart';
import 'package:zero_to_hero/src/ui/strings.dart';

import 'country_list_tile.dart';
import 'search_bar.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  CountryBloc countryBloc;
  SearchInputBloc searchInputBloc;
  @override
  void initState() {
    countryBloc = CountryBloc();
    searchInputBloc = SearchInputBloc();
    super.initState();
  }

  @override
  void dispose() {
    searchInputBloc.dispose();
    countryBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: countryBloc.country,
          builder: (context, AsyncSnapshot<CountriesItemModel> snapshot) {
            return Column(
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
                          searchInputBloc: searchInputBloc,
                        ),
                      ),
                    ],
                  ),
                ),
                snapshot.hasData
                    ? buildList(snapshot.data.countries, context)
                    : snapshot.hasError
                        ? Text(snapshot.error.toString())
                        : Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
              ],
            );
          }),
    );
  }

  Widget buildList(List<CountryItemModel> countries, BuildContext context) {
    return StreamBuilder(
        stream: searchInputBloc.searchInput,
        builder: (context, AsyncSnapshot<String> snapshot) {
          // print(snapshot.connectionState);
          if (snapshot.hasData) {
            // print("data: ${snapshot.data}");
            String input = snapshot.data;
            List<CountryItemModel> list = [];
            for (int i = 0; i < countries.length; i++) {
              if (countries[i]
                  .country
                  .toLowerCase()
                  .contains(input.toLowerCase())) list.add(countries[i]);
            }
            print("input: $input");
            print("length: ${list.length}");
            return getList(list);
          } else if (snapshot.hasError)
            return Text(snapshot.error.toString());
          else
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
        });
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
