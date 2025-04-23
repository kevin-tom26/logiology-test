import 'package:prodex/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class PElevatedButtonTheme {
  PElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: PColors.textSecondary,
      backgroundColor: PColors.primary,
      // disabledForegroundColor: TColors.darkGrey,
      // disabledBackgroundColor: TColors.buttonDisabled,
      side: const BorderSide(color: PColors.primary),
      textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: PColors.textSecondary,
          fontWeight: FontWeight.w400),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
