import 'package:cubic_task/core/config/di/di.dart';
import 'package:cubic_task/presentation/map/manager/map_cubit.dart';
import 'package:cubic_task/presentation/map/pages/need_location_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../core/app_assets/lottie_assets.dart';
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
          var cubit = context.read<MapCubit>();
          if (state is GetLocationSuccess) {
            cubit.updateCurrentPosition(
                latLng: LatLng(
                    state.position!.latitude, state.position!.longitude));
            cubit.calculateDistance(branches);
          }
          if (state is CalculateDistanceSuccess) {
            Future.delayed(const Duration(seconds: 4), () {
              cubit.updateCurrentPosition(
                  latLng: LatLng(double.parse(state.selectedBranch.branchLat!),
                      double.parse(state.selectedBranch.branchLng!)),
                  zoom: 9);
            });
          }
        },
        builder: (context, state) {
          var cubit = context.read<MapCubit>();

          return Scaffold(
            appBar: AppBar(
              title: Text("map.title".tr()),
              centerTitle: true,
              backgroundColor: theme.primaryColor,
              elevation: 0,
            ),
            body: Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  !cubit.serviceEnabled || cubit.needLocationPermission
                      ? const NeedLocationScreen()
                      : GoogleMap(
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
                  // Use a Flexible widget to allow for proper layout calculation
                  // SizedBox(
                  //   height: 200,
                  //   child: DraggableScrollableSheet(
                  //     builder: (context, scrollController) {
                  //       return Container(
                  //         height: 200,
                  //         decoration: BoxDecoration(
                  //           color: theme.primaryColor,
                  //           borderRadius: const BorderRadius.only(
                  //             topLeft: Radius.circular(16.0),
                  //             topRight: Radius.circular(16.0),
                  //           ),
                  //         ),
                  //         child: SingleChildScrollView(
                  //           padding: const EdgeInsets.all(6),
                  //           physics: const ClampingScrollPhysics(),
                  //           controller: scrollController,
                  //           child: Column(
                  //             children: [
                  //               Container(
                  //                 width: 30,
                  //                 height: 4,
                  //                 padding: const EdgeInsets.all(8.0),
                  //                 decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius: BorderRadius.circular(8.0),
                  //                 ),
                  //               ),
                  //               const Padding(
                  //                 padding: EdgeInsets.all(8.0),
                  //                 child: Text(
                  //                   'Branches',
                  //                   style: TextStyle(
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     expand: true,
                  //     minChildSize: 0.3,
                  //     maxChildSize: 1.0,
                  //     initialChildSize: 0.4,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
