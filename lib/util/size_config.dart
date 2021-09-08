import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static double? screenWidth;
  static late double screenHeight;
  static double? deviceAspectRatio;
  static double? devicePixelDensity;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  static double? sidePadding;
  static late double sidePadding10;
  static late double topPadding;
  static double? topPadding10;
  static double? fontSizeBigName;
  static double? fontSizeRegularText;
  static double? fontSizeName;
  static double? fontSizeSmall;
  static double? fontPixelSize;



  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    deviceAspectRatio = _mediaQueryData.size.aspectRatio;
    devicePixelDensity = _mediaQueryData.devicePixelRatio;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    sidePadding = screenHeight * 0.01;
    sidePadding10 = screenWidth! * 0.1;
    topPadding = screenHeight * 0.02;
    topPadding10 = screenHeight * 0.1;
    fontSizeBigName = screenWidth! * 0.05;
    fontSizeRegularText = screenWidth! * 0.037;
    fontSizeName = screenWidth! * 0.04;
    fontSizeSmall = screenWidth! * 0.033;

    fontPixelSize = devicePixelDensity! * 10;
  }
}