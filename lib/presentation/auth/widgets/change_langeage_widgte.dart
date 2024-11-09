import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_assets/svg_assets.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: SizedBox(
        width: 120,
        child: AnimatedToggleSwitch<String>.rolling(
          textDirection: TextDirection.ltr,
          borderWidth: 2,
          active: true,
          fittingMode: FittingMode.none,
          spacing: 10,
          minTouchTargetSize: 10,
          styleAnimationType: AnimationType.onSelected,
          style: ToggleStyle(
            borderRadius: BorderRadius.circular(16),
            backgroundColor: theme.scaffoldBackgroundColor,
            indicatorColor: theme.primaryColor,
          ),
          current: context.locale.languageCode,
          values: const ['en', 'ar'],
          onChanged: (value) => context.setLocale(Locale(value)),
          iconBuilder: (value, foreground) {
            return SvgPicture.asset(
              value == 'en' ? SvgAssets.instance.en : SvgAssets.instance.ar,
            );
          },
        ),
      ),
    );
  }
}
