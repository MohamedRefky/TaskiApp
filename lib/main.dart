import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Core/Services/prefrances_maneger.dart';
import 'package:tasky/Core/Theme/dark_theme.dart';
import 'package:tasky/Core/Theme/light_theme.dart';
import 'package:tasky/Core/Theme/themes_controller.dart';
import 'package:tasky/Core/constants/storage_key.dart';
import 'package:tasky/Features/navigaton/main_screen.dart';
import 'package:tasky/Features/tasks/controller/tasks_controller.dart';
import 'package:tasky/Features/welcome/welcome_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefrancesManeger().init();
  ThemesController().init();

  String? username = PrefrancesManeger().getString(StorageKey.username);

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemesController.themeNotifier,
      builder: (context, ThemeMode themeMode, Widget? child) {
        return ChangeNotifierProvider<TasksController>(
          create: (_) => TasksController()..init(),
          child: MaterialApp(
            title: 'Tasky App',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            home: username == null ? WelcomeScreen() : MainScreen(),
          ),
        );
      },
    );
  }
}
