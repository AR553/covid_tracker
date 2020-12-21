import 'package:flutter/material.dart';

import '../dimens.dart';
import '../my_colors.dart';
import '../strings.dart';

class CountryListTile extends StatelessWidget {
  final List<Color> _colors = [
    MyColors.PRIMARY,
    MyColors.YELLOW,
    MyColors.RED,
  ];
  final String country;
  final Severity severity;
  final int cases;

  CountryListTile({
    this.country = '',
    this.severity = Severity.low,
    this.cases = 0,
  });

  @override
  Widget build(Object context) {
    return Padding(
      padding: EdgeInsets.all(
        Dimens.INSET_S,
      ),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: MyColors.ON_BACKGROUND_VARIANT,
          ),
          borderRadius: BorderRadius.circular(
            Dimens.RADIUS_S,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            Dimens.RADIUS_S,
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                color: _colors[severity.index],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(
                    Dimens.INSET_S,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        country,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        _getValue(cases) + ' ' + Strings.CASES,
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 40,
                color: MyColors.ON_BACKGROUND_VARIANT,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _reverse(String value) {
    int l = value.length;
    String temp = "";
    for (int i = l - 1; i >= 0; i--) temp += value[i];
    return temp;
  }

  String _getValue(int value) {
    // print(value);
    String valueString = _reverse(value.toString());
    String strValue = value.toString();
    int l = strValue.length;
    if (l > 3) {
      strValue = valueString.substring(0, 3);
      for (int i = 3; i < l; i += 1) {
        if (i % 2 != 0) strValue += ",";
        strValue += valueString[i];
      }
      return _reverse(strValue);
    }
    return strValue;
  }
}

enum Severity {
  low,
  medium,
  extreme,
}
