import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';

import '../../../core/app_assets/lottie_assets.dart';
import '../manager/map_cubit.dart';

class NeedLocationScreen extends StatelessWidget {
  const NeedLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MapCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(
          flex: 3,
        ),
        Lottie.asset(LottieAssets.instance.noLocation),
        const Spacer(),
        Text(cubit.needLocationPermission
            ? "map.noLocation_permission".tr()
            : "map.noLocation_services".tr()),
        const Spacer(),
        ElevatedButton(
            onPressed: () async {
              if (!cubit.serviceEnabled) {
                Geolocator.openLocationSettings();
              } else if (cubit.needLocationPermission) {
                await cubit.checkLocationPermission().then((value) {
                  if (!value) {
                    Geolocator.openAppSettings();
                  }
                });
              }
            },
            child: Text("map.enableLocation".tr())),
        const Spacer(
          flex: 3,
        ),
      ],
    );
  }
}
