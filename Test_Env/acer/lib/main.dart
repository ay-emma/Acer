import 'package:acer/src/demo/feturesPage.dart';
import 'package:acer/src/demo/startOrContinueCourse.dart';
import 'package:acer/src/themes/colors.dart';
import 'package:acer/src/themes/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/all.dart';

import 'src/demo/courseWelcomePage.dart';
import 'src/demo/firstscreen.dart';
import 'src/demo/loginPage.dart';
import 'src/demo/preStartOrContinueCourse.dart';
import 'src/demo/user_coursesPage.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

final currentTheme = ChangeNotifierProvider<ThemeModel>((ref) => ThemeModel());

class MyApp extends HookWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final themeProvider = useProvider(currentTheme);
    return MaterialApp(
      title: 'Acer Demo',
      theme: themeProvider.currentTheme,
      home: PreStatOrContinueCourse(),
    );
  }
}
