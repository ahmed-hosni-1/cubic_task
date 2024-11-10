import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cubic_task/domain/entities/auth/branch_entities.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../core/app_assets/icon_assets.dart';
import '../../../main.dart';

part 'map_state.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  Position? position;
  Set<Marker> markers = {};
  BranchEntities? nearestBranch;

  bool serviceEnabled = false;
  bool needLocationPermission = false;

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  bool isRequestInProgress = false;

  Future<bool> checkLocationPermission() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        needLocationPermission = true;
        return false;
      }
      ;
    }
    if (permission == LocationPermission.deniedForever) {
      needLocationPermission = true;
    }
    return permission != LocationPermission.deniedForever;
  }

  Future<void> getLocation() async {
    if (isRequestInProgress) return;
    isRequestInProgress = true;

    try {
      if (await checkLocationPermission()) {
        position = await Geolocator.getCurrentPosition();
        emit(GetLocationSuccess(position!));
      } else {
        emit(GetLocationFailed());
      }
    } catch (e) {
      emit(GetLocationFailed());
    } finally {
      isRequestInProgress = false;
    }
  }

  Future<void> updateCurrentPosition(
      {required LatLng latLng, double zoom = 13}) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: zoom)),
    );
    emit(UpdateCurrentPosition());
  }


  void moveToMyLocation() async {
    updateCurrentPosition(latLng: LatLng(position!.latitude, position!.longitude));
  }

  Future<void> calculateDistance(List<BranchEntities> branches) async {
    if (position == null) {
      emit(CalculateDistanceFailed());
      return;
    }

    double nearestDistance = double.infinity;

    for (var branch in branches) {
      if (branch.branchLat != null && branch.branchLng != null) {
        double branchLat = double.parse(branch.branchLat!);
        double branchLng = double.parse(branch.branchLng!);

        double distance = Geolocator.distanceBetween(
          position!.latitude,
          position!.longitude,
          branchLat,
          branchLng,
        );

        if (distance < nearestDistance) {
          nearestDistance = distance;
          nearestBranch = branch;
        }
        await _addMarkerForBranch(branch);
      }
    }

    if (nearestBranch != null) {
      emit(CalculateDistanceSuccess(nearestBranch!));
    } else {
      emit(CalculateDistanceFailed());
    }
  }

  Future<void> _addMarkerForBranch(BranchEntities branch) async {
    var icon = await BitmapDescriptor.asset(
        const ImageConfiguration(
          size: Size(42, 60),
        ),
        IconsAssets.instance.locationMarker);
    markers.add(Marker(
      markerId: MarkerId(branch.branchId),
      icon: icon,
      infoWindow: InfoWindow(
        title: branch.branchName,
        snippet: branch.branchCity ?? branch.branchAddress ?? branch.branchCode,
      ),
      position: LatLng(
          double.parse(branch.branchLat!), double.parse(branch.branchLng!)),
    ));
  }
}
