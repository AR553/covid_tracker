import 'package:flutter/material.dart';

import 'ui/home/home_page.dart';
import 'ui/my_colors.dart';
import 'ui/strings.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.TITLE,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: MyColors.PRIMARY,
          onPrimary: Colors.white,
          secondary: MyColors.SECONDARY,
          onBackground: MyColors.ON_BACKGROUND,
          onSecondary: Colors.white,
        ),
      ),
      home: HomePage(),
    );
  }
}
