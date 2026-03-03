import 'package:flutter/material.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Core/Theme/dark_theme.dart';
import 'package:tasky/Core/Theme/light_theme.dart';
import 'package:tasky/Core/Theme/themes_controller.dart';
import 'package:tasky/Features/navigaton/main_screen.dart';
import 'package:tasky/Features/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefrancesManeger().init();
  ThemesController().init();
  String? name = PrefrancesManeger().getString('username');

  runApp(MainApp(name: name));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemesController.themeNotifier,
      builder: (context, ThemeMode value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value,
          home: name == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}
