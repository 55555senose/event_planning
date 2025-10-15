// import 'package:event_planning/utils/app_colors.dart';
// import 'package:event_planning/utils/app_styles.dart';
// import 'package:flutter/material.dart';
// class AppTheme{
//   static final ThemeData lightTheme = ThemeData(
//     scaffoldBackgroundColor: AppColors.whiteBgColor,
//     textTheme: TextTheme(
//       headlineLarge: AppStyles.bold20Black
//     )
//   );
//
//   static final ThemeData darkTheme = ThemeData(
//       scaffoldBackgroundColor: AppColors.primaryDark,
//
//       textTheme: TextTheme(
//   headlineLarge: AppStyles.bold20White
//    )
//   );
// }
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.whiteBgColor,
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20Black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteBgColor,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.primaryDark,
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20White,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
