import 'package:flutter/material.dart';
import 'package:prodex/utils/constants/colors.dart';

class PTextFormFieldTheme {
  PTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: PColors.iconBlack,
      suffixIconColor: PColors.iconBlack,
      // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
      // labelStyle: const TextStyle()
      //     .copyWith(fontSize: TSizes.fontSizeMd, color: TColors.black),
      hintStyle:
          const TextStyle().copyWith(fontSize: 14, color: PColors.darkGrey),
      errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
      // floatingLabelStyle:
      //     const TextStyle().copyWith(color: TColors.black.withOpacity(0.8)),
      filled: true,
      fillColor: PColors.lightContainer,
      border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 1, color: PColors.warning),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 2, color: PColors.warning),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15));
}
