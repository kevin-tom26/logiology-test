import 'package:flutter/material.dart';
import 'package:prodex/utils/constants/colors.dart';

class PTextSelectionTheme {
  PTextSelectionTheme._();

  static TextSelectionThemeData textSelctionThemeTheme =
      const TextSelectionThemeData(
          cursorColor: PColors.primary, // Cursor color
          selectionColor: PColors.secondary, // Highlighted text background
          selectionHandleColor: PColors.primary // Little draggable handles
          );
}
