import 'package:flutter/material.dart';

import 'package:zero_to_hero/src/blocs/covid_bloc.dart';
import 'package:zero_to_hero/src/models/date_item_model.dart';
import 'package:zero_to_hero/src/ui/clear_app_bar.dart';
import 'package:zero_to_hero/src/ui/dimens.dart';
import 'package:zero_to_hero/src/ui/global_stats/curved_tab_bar.dart';
import 'package:zero_to_hero/src/ui/global_stats/plain_scroll_behavior.dart';
import 'package:zero_to_hero/src/ui/global_stats/stat_chart.dart';
import 'package:zero_to_hero/src/ui/global_stats/stat_content.dart';
import 'package:zero_to_hero/src/ui/strings.dart';
import 'plain_scroll_behavior.dart';

class GlobalStatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<GlobalStatsPage> {
  final double _heightTbv = 200;
  final double _heightTabBar = 25;
  final List<Widget> _tabs = [
    Tab(
      text: Strings.TOTAL,
    ),
    Tab(
      text: Strings.TODAY,
    ),
    Tab(
      text: Strings.YESTERDAY,
    ),
  ];
  final EdgeInsets _paddingTbv = EdgeInsets.all(Dimens.INSET_M);

  CovidBloc covidBloc;
  @override
  void initState() {
    covidBloc = CovidBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ClearAppBar(
                    title: Text(
                      Strings.GLOBAL_STATISTICS,
                    ),
                  ),
                  DefaultTabController(
                    length: _tabs.length,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.INSET_M),
                          child: Container(
                            height: _heightTabBar,
                            child: CurvedTabBar(
                              tabs: _tabs,
                            ),
                          ),
                        ),
                        Container(
                          height: _heightTbv,
                          child: ScrollConfiguration(
                            behavior: PlainScrollBehavior(),
                            child: TabBarView(
                              children: _tabContentList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Dimens.RADIUS_HOME_CONTAINER),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    Dimens.INSET_M,
                  ),
                  child: StatChart(
                    stream: covidBloc.timeline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _tabContentList() {
    final streams = [
      covidBloc.total,
      covidBloc.today,
      covidBloc.yesterday,
    ];
    return streams
        .map((item) => _tabContentView(
              stream: item,
            ))
        .toList();
  }

  Widget _tabContentView({@required Stream<DateItemModel> stream}) {
    return Padding(
      padding: _paddingTbv,
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<DateItemModel> snapshot) {
          if (snapshot.hasData) {
            return StatContent(
              affected: snapshot.data.cases,
              deaths: snapshot.data.deaths,
              recovered: snapshot.data.recovered,
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return _progressCircle();
        },
      ),
    );
  }

  Widget _progressCircle() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.white,
        ),
      ),
    );
  }
}
