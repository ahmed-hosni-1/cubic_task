import 'dart:core';

class SvgAssets {
  SvgAssets._();
  static SvgAssets? _instance;
  static SvgAssets get instance => _instance ??= SvgAssets._();

  String logo = 'assets/logo/logo.svg';
  String ar = 'assets/icons/ar.svg';
  String en = 'assets/icons/en.svg';
  String apple = 'assets/icons/apple.svg';
  String google = 'assets/icons/google.svg';
  String locationMarker = 'assets/icons/location_marker_svg.svg';
}
