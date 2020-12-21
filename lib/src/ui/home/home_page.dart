import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zero_to_hero/src/blocs/country_bloc.dart';
import 'package:zero_to_hero/src/blocs/stats_bloc.dart';

import '../about_page.dart';
import '../countries/country_page.dart';
import '../global_stats/global_stats_page.dart';
import '../home/blue_tab_bar.dart';

/// Screen containing bottom appbar
class HomePage extends StatefulWidget {
  final StatsBloc statsBloc = StatsBloc();
  final CountryBloc countryBloc = CountryBloc();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _tabs = [
    Tab(
      icon: Icon(
        Icons.public,
      ),
    ),
    Tab(
      icon: Icon(
        Icons.location_on,
      ),
    ),
    Tab(
      icon: Icon(
        Icons.info,
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: TabBarView(
          children: [
            GlobalStatsPage(statsBloc: widget.statsBloc),
            CountryPage(countryBloc: widget.countryBloc),
            AboutPage(),
          ],
        ),
        bottomNavigationBar: BlueTabBar(tabs: _tabs),
      ),
    );
  }

  @override
  void dispose() {
    widget.countryBloc.dispose();
    widget.statsBloc.dispose();
    super.dispose();
  }
}
