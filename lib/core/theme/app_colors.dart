import 'package:flutter/material.dart';

class AppColors{
  AppColors._();
  static AppColors? _instance;
  static AppColors get instance => _instance ??= AppColors._();

  final Color primaryColor = const Color(0xff004785);
  final Color secondaryColor = const Color(0xff1E2019);
  final Color backgroundColor = const Color(0xffffffff);

}