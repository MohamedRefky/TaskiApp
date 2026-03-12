import 'package:flutter/material.dart';
import 'package:tasky/Core/constants/app_sizes.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF6F7F9),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp20,
    ),
    iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  ),
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    secondary: Color(0xFF3A4640),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r4),
    ),
    side: BorderSide(color: Color(0xFFD1DAD6), width: AppSizes.w2),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.black)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r30),
    ),
    extendedTextStyle: TextStyle(
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w500,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
      fontSize: AppSizes.sp32,
    ),
    displayMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp28,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp24,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: AppSizes.sp16),
    labelLarge: TextStyle(color: Colors.black, fontSize: AppSizes.sp24),
    labelSmall: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xFF3A4640),
      fontSize: AppSizes.sp14,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0xFF6A6A6A),
      fontSize: AppSizes.sp16,
      decorationColor: Color(0xFF49454F),
      decoration: TextDecoration.lineThrough,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: AppSizes.w1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: AppSizes.w1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Colors.red, width: AppSizes.w1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: AppSizes.w1),
    ),
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
  ),
  iconTheme: IconThemeData(color: Color(0xFF161F1B), size: AppSizes.sp24),
  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6), thickness: 1),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.white,
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF6F7F9),
    selectedItemColor: Color(0xFF14A662),
    unselectedItemColor: Color(0xFF3A4640),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.r16)),
    shadowColor: Color(0xFF3A4640),
    elevation: AppSizes.r2,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        color: Colors.black,
        fontSize: AppSizes.sp20,
        fontWeight: FontWeight.w400,
      ),
    ),
  ),
);
