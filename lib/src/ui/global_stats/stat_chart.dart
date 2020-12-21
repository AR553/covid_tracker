import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zero_to_hero/src/models/timeline_item_model.dart';
import 'package:zero_to_hero/src/ui/dimens.dart';
import 'package:zero_to_hero/src/ui/my_colors.dart';
import 'package:zero_to_hero/src/ui/strings.dart';

class StatChart extends StatelessWidget {
  final Stream<List<TimelineItemModel>> _stream;

  StatChart({@required Stream<List<TimelineItemModel>> stream})
      : _stream = stream;

  @override
  Widget build(BuildContext context) {
    double interval;
    double minValue;
    double maxValue;
    return StreamBuilder<List<TimelineItemModel>>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          double temp =
              (_maxCases(snapshot.data) - _minCases(snapshot.data)) / 47;
          interval = 10;
          while (temp >= 1) {
            temp /= 10;
            interval *= 10;
          }
          minValue = (_minCases(snapshot.data) / interval).floor() * interval;
          maxValue = (_maxCases(snapshot.data) / interval).ceil() * interval;
          // print("interval: $interval");
          // print("minValue: $minValue");
          // print("maxValue: $maxValue");
          return Column(
            children: [
              Text(
                Strings.DAILY_NEW_CASES,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: Dimens.INSET_S,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.5,
                  // chart needs to be inside a sized container to prevent overflow
                  child: BarChart(
                    BarChartData(
                      barGroups: _toBarChartData(snapshot.data),
                      minY:
                          minValue, //interval can be subtracted as a margin for minimum value
                      maxY:
                          maxValue, //interval can be added as a margin for maximum value
                      borderData: FlBorderData(
                        show: false,
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: SideTitles(
                          showTitles: true,
                          interval: interval,
                          reservedSize: Dimens.INSET_M,
                        ),
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTitles: (value) {
                            final date = DateTime.fromMillisecondsSinceEpoch(
                                value.toInt());
                            final formatter = DateFormat('MMM-dd');
                            return formatter.format(date);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              MyColors.RED,
            ),
          ),
        );
      },
    );
  }

  static List<BarChartGroupData> _toBarChartData(
      List<TimelineItemModel> timeline) {
    return timeline.map((model) {
      return BarChartGroupData(
        x: model.date.millisecondsSinceEpoch,
        barRods: [
          BarChartRodData(
            y: model.cases.toDouble(),
            colors: [
              MyColors.RED,
            ],
          ),
        ],
      );
    }).toList();
  }

  int _maxCases(List<TimelineItemModel> timeline) {
    return timeline.reduce((val1, val2) {
      return val1.cases > val2.cases ? val1 : val2;
    }).cases;
  }

  int _minCases(List<TimelineItemModel> timeline) {
    return timeline.reduce((val1, val2) {
      return val1.cases < val2.cases ? val1 : val2;
    }).cases;
  }
}
