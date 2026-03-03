import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';

class ThemesController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  init() {
    bool result = PrefrancesManeger().getBool('theme') ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static toggleTheme() {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      PrefrancesManeger().setBool('theme', false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      PrefrancesManeger().setBool('theme', true);
    }
  }
 static bool isDark() =>themeNotifier.value == ThemeMode.dark;
}
