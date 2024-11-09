import 'package:cubic_task/core/config/page_routes_name.dart';
import 'package:cubic_task/presentation/map/pages/map_screen.dart';
import 'package:cubic_task/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../presentation/auth/pages/registration_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRoutesName.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen(),settings: settings);
        case PageRoutesName.registrationScreen:
        return MaterialPageRoute(builder: (_) =>  RegistrationScreen(),settings: settings);
        case PageRoutesName.mapScreen:
        return MaterialPageRoute(builder: (_) =>  MapScreen(),settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
