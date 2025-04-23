import 'package:flutter/material.dart';

extension ResponsiveFontSize on BuildContext {
  double responsiveFontSize(double baseFontSize,
      {double min = 12, double max = double.infinity}) {
    final screenWidth = MediaQuery.of(this).size.width;
    const baseWidth = 1440.0;

    double scaledSize = baseFontSize * (screenWidth / baseWidth);

    return scaledSize.clamp(min, max);
  }
}

extension ResponsiveUtils on BuildContext {
  double scale(double value, {double min = 0, double max = double.infinity}) {
    const baseWidth = 375.0;
    double screenWidth = MediaQuery.of(this).size.width;
    return (value * (screenWidth / baseWidth)).clamp(min, max);
  }

  double inverseScale(double value,
      {double min = 0, double max = double.infinity}) {
    const baseWidth = 375.0;
    final screenWidth = MediaQuery.of(this).size.width;
    return (value * (baseWidth / screenWidth)).clamp(min, max);
  }
}
