import 'package:cubic_task/core/app_assets/icon_assets.dart';
import 'package:cubic_task/core/extensions/context.dart';
import 'package:cubic_task/presentation/map/manager/map_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/app_assets/svg_assets.dart';
import '../../../domain/entities/auth/branch_entities.dart';

class BranchesBottomSheet extends StatelessWidget {
  const BranchesBottomSheet({
    super.key,
    required this.theme,
    required this.branches,
    required this.cubit,
  });

  final ThemeData theme;
  final List<BranchEntities> branches;
  final MapCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.32,
      child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.5,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              height: context.height * 0.22,
              width: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 16.0,
                ),
                physics: const ClampingScrollPhysics(),
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                          height: 8,
                          width: 64,
                          decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(16))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SvgPicture.asset(
                        SvgAssets.instance.logo,
                        colorFilter: ColorFilter.mode(
                            theme.primaryColor, BlendMode.srcIn),
                        width: 80,
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.15 + 16,
                      width: context.width,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        scrollDirection: Axis.horizontal,
                        itemCount: branches.length,
                        itemBuilder: (context, index) {
                          var branch = branches[index];
                          return GestureDetector(
                            onTap: () {
                              cubit.updateCurrentPosition(
                                  latLng: LatLng(
                                      double.parse(branch.branchLat!),
                                      double.parse(branch.branchLng!)),
                                  zoom: 13);
                            },
                            child: Stack(
                              alignment: context.locale.languageCode == "en"
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              children: [
                                Container(
                                  width: context.width * 0.5,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset(
                                        SvgAssets.instance.locationMarker,
                                        height: 80,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            branches[index].branchName,
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(color: Colors.white),
                                          ),
                                          Text(
                                            branches[index].branchNameAr ?? "",
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  margin: EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(16),
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    branch.branchId ==
                                            cubit.nearestBranch!.branchId
                                        ? "map.nearest".tr()
                                        : "map.available".tr(),
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 65,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(16),
                                    backgroundColor: theme.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {
                                    cubit.updateCurrentPosition(
                                        latLng: LatLng(
                                          double.parse(
                                              cubit.nearestBranch!.branchLat!),
                                          double.parse(
                                              cubit.nearestBranch!.branchLng!),
                                        ),
                                        zoom: 13);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "map.nearest_branch".tr(),
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            height: 65,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16),
                                  backgroundColor: theme.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  cubit.moveToMyLocation();
                                },
                                child: const Icon(
                                  Icons.my_location,
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
