import 'package:cubic_task/core/config/di/di.dart';
import 'package:cubic_task/presentation/map/manager/map_cubit.dart';
import 'package:cubic_task/presentation/map/widgets/nearest_branche_toast.dart';
import 'package:cubic_task/presentation/map/pages/need_location_screen.dart';
import 'package:cubic_task/presentation/map/widgets/branches_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/entities/auth/branch_entities.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var branches =
        ModalRoute.of(context)!.settings.arguments as List<BranchEntities>;
    return BlocProvider(
      create: (context) => getIt<MapCubit>()..getLocation(),
      child: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {
          print(state);
          var cubit = context.read<MapCubit>();
          if (state is GetLocationSuccess) {
            cubit.updateCurrentPosition(
                latLng:
                    LatLng(state.position.latitude, state.position.longitude));
            cubit.calculateDistance(branches, state.position);
          }
          if (state is CalculateDistanceSuccess) {
            Future.delayed(const Duration(seconds: 1), () {
              Toastification().dismissAll();
              Toastification().show(
                  autoCloseDuration: const Duration(seconds: 5),
                  overlayState: Overlay.of(context),
                  showProgressBar: false,
                  backgroundColor: theme.primaryColor,
                  alignment: Alignment.topCenter,
                  context: context,
                  type: ToastificationType.success,
                  applyBlurEffect: false,
                  closeButtonShowType: CloseButtonShowType.none,
                  style: ToastificationStyle.simple,
                  icon: const SizedBox(),
                  padding: EdgeInsets.zero,
                  dragToClose: true,
                  showIcon: false,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  title: NearestBranchToast(theme: theme, cubit: cubit));
            });
          }
        },
        builder: (context, state) {
          var cubit = context.read<MapCubit>();

          return Scaffold(
            body: Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  if (!cubit.serviceEnabled || cubit.needLocationPermission)
                    const NeedLocationScreen()
                  else
                    Stack(
                      children: [
                        GoogleMap(
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: true,
                          mapType: MapType.normal,
                          markers: cubit.markers,
                          onMapCreated: (controller) {
                            cubit.mapController.complete(controller);
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(cubit.position?.latitude ?? 0,
                                cubit.position?.longitude ?? 0),
                            zoom: 13,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: BranchesBottomSheet(
                              theme: theme, branches: branches, cubit: cubit),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
