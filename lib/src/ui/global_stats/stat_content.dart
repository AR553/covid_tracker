import 'package:zero_to_hero/src/ui/dimens.dart';
import 'package:zero_to_hero/src/ui/global_stats/stat_tile.dart';
import 'package:zero_to_hero/src/ui/my_colors.dart';
import 'package:zero_to_hero/src/ui/strings.dart';
import 'package:flutter/material.dart';

class StatContent extends StatelessWidget {
  StatContent({
    this.affected = 0,
    this.deaths = 0,
    this.recovered = 0,
  });

  final int affected;
  final int deaths;
  final int recovered;

  final List<Color> _colors = [
    MyColors.YELLOW,
    MyColors.RED,
    MyColors.GREEN,
    Color(0xFF5db6f5),
    Color(0xFFa25ffa),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: StatTile(
                  title: Strings.AFFECTED,
                  value: affected,
                  color: _colors[0],
                ),
              ),
              // Using sized box for easier padding
              SizedBox(
                width: Dimens.INSET_S,
              ),
              Expanded(
                child: StatTile(
                  title: Strings.DEATHS,
                  value: deaths,
                  color: _colors[1],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimens.INSET_S,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: StatTile(
                  title: Strings.RECOVERED,
                  value: recovered,
                  color: _colors[2],
                ),
              ),
              SizedBox(
                width: Dimens.INSET_S,
              ),
              Expanded(
                child: StatTile(
                  title: Strings.ACTIVE,
                  value: affected - deaths - recovered,
                  color: _colors[3],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
