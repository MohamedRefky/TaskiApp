import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF181818),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF181818),
    centerTitle: true,
    titleTextStyle: TextStyle(color: Color(0xFFFFFCFC), fontSize: 20.sp),
    iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
  ),
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    secondary: Color(0xFFC6C6C6),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(color: Color(0xFF6E6E6E), width: 2.w),
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
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
  )),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
    extendedTextStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400,
      fontSize: 32.sp,
    ),
    displayMedium: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 28.sp,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(color: Colors.white, fontSize: 16.sp),
    labelLarge: TextStyle(color: Colors.white, fontSize: 24.sp),
    labelSmall: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xFFC6C6C6),
      fontSize: 14.sp,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0xFFA0A0A0),
      fontSize: 16.sp,
      decorationColor: Color(0xFFA0A0A0),
      decoration: TextDecoration.lineThrough,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: Colors.red, width: .75.w),
    ),
    filled: true,
    fillColor: Color(0xFF282828),
    hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
  ),
  iconTheme: IconThemeData(color: Color(0xFFFFFCFC), size: 24.sp),
  dividerTheme: DividerThemeData(color: Color(0xFFC6C6C6), thickness: 1),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: 16.sp,
      color: Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.black,
    selectionHandleColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF181818),
    selectedItemColor: Color(0xFF15B86C),
    unselectedItemColor: Color(0xFFC6C6C6),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFF181818),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Color(0xFF15B86C), width: 1.w),
    ),
    shadowColor: Color(0xFF15B86C),
    elevation: 2.r,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w400),
    ),
  ),
);
