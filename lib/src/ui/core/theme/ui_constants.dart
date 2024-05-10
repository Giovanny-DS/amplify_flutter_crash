import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// UI Constants for the application
class UIConstants {
  /// App title
  static const String materialAppTitle = 'Amplify crash exampple';

  /// colorPrimary -> RGBO(102, 48, 255, 1)
  static const Color colorPrimary = Color.fromRGBO(102, 48, 255, 1);

  /// Configure the app to be Responsive in resizing on mobile and web
  static Widget materialAppResponsiveBuilder(BuildContext context, Widget? widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 3840,
        breakpoints: const <ResponsiveBreakpoint>[
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.resize(900, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ],
      );

  /// Defines the general themes for the application
  static final ThemeData materialAppThemeData = ThemeData(
    primaryColor: colorPrimary,
    iconButtonTheme: IconButtonThemeData(style: ButtonStyle(iconColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) => colorPrimary))),
    useMaterial3: true,
  );

  /// Static function for calling CircularProgress
  static Widget showCircularProgress({required double width, required double height, required Color color}) => Center(
        child: SizedBox(
          height: height,
          width: width,
          child: CircularProgressIndicator(color: color, strokeWidth: 2),
        ),
      );
}
