import 'package:cubic_task/core/config/app_router.dart';
import 'package:cubic_task/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/config/di/di.dart';
import 'core/config/page_routes_name.dart';
import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(EasyLocalization(
      startLocale: const Locale('en'),
      path: 'assets/translations',
      saveLocale: true,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      navigatorKey: navigatorKey,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'Cubic Task',
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: PageRoutesName.splash,
    );
  }
}
