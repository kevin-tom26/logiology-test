import 'package:prodex/core/theme/app_theme/elevated_button_theme.dart';
import 'package:prodex/core/theme/app_theme/icon_theme.dart';
import 'package:prodex/core/theme/app_theme/text_field_theme.dart';
import 'package:prodex/core/theme/app_theme/text_selection_theme.dart';
import 'package:prodex/core/theme/app_theme/text_theme.dart';
import 'package:prodex/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class PAppTheme {
  PAppTheme._();

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: PColors.softGrey,
    brightness: Brightness.light,
    //primaryColor: WColors.primary,
    textTheme: PTextTheme.ligthTextTheme,
    iconTheme: PIconTheme.ligthIconTheme,
    scaffoldBackgroundColor: PColors.white,
    textSelectionTheme: PTextSelectionTheme.textSelctionThemeTheme,
    // appBarTheme: WAppBarTheme.lightAppBarTheme,
    // checkboxTheme: WCheckboxTheme.lightCheckboxTheme,
    // bottomSheetTheme: WBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: PElevatedButtonTheme.lightElevatedButtonTheme,
    // outlinedButtonTheme: WOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: PTextFormFieldTheme.lightInputDecorationTheme,
  );
}
