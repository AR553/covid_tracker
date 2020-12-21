import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../about_page.dart';
import '../countries/country_page.dart';
import '../global_stats/global_stats_page.dart';
import '../home/blue_tab_bar.dart';

/// Screen containing bottom appbar
class HomePage extends StatelessWidget {
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
            GlobalStatsPage(),
            CountryPage(),
            AboutPage(),
          ],
        ),
        bottomNavigationBar: BlueTabBar(tabs: _tabs),
      ),
    );
  }
}
