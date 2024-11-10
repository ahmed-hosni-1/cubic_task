import 'dart:core';

class IconsAssets {
  IconsAssets._();
  static IconsAssets? _instance;
  static IconsAssets get instance => _instance ??= IconsAssets._();

  String  atmLocation = "assets/icons/atm.png";
  String  locationMarker = "assets/icons/location_marker.png";
  String  locationMarkerWhite = "assets/icons/location_marker_white.png";

}
