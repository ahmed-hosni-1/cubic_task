import 'package:flutter/material.dart';

extension FormatPoints on String {
  String formatPoints(BuildContext context) {
    int length = this.length;
    String value = this;
    int counter = 1;
    while (counter * 3 < length) {
      value =
          '${value.substring(0, length - counter * 3)},${value.substring(length - counter * 3, (length + counter - 1))}';
      counter += 1;
    }
    return value;
  }
}
