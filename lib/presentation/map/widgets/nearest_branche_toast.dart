import 'package:cubic_task/core/extensions/context.dart';
import 'package:cubic_task/presentation/map/manager/map_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/app_assets/icon_assets.dart';

class NearestBrancheToast extends StatelessWidget {
  const NearestBrancheToast({
    super.key,
    required this.theme,
    required this.cubit,
  });

  final ThemeData theme;
  final MapCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.width * 0.2,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            IconsAssets.instance.locationMarkerWhite,
            width: 35,
          ),
          const SizedBox(
            width: 16,
          ),
          SizedBox(
            width: context.width * 0.7,
            child: Text(
              "${"map.nearest_branch_desc".tr()} ${context.locale.languageCode == "en" ? cubit.nearestBranch!.branchName : cubit.nearestBranch?.branchNameAr ?? cubit.nearestBranch!.branchName}",
              style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
