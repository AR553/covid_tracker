import '../dimens.dart';
import 'package:flutter/material.dart';

class StatTile extends StatelessWidget {
  final Color color;
  final String title;
  final int value;

  StatTile({
    this.color = const Color(0x44FFFFFF),
    this.title = '',
    this.value = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(Dimens.INSET_S),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white,
                  ),
            ),
            Text(
              _getValue(value),
              style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.RADIUS_S),
        color: color,
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
