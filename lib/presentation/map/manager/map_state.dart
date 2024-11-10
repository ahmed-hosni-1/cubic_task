part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class GetLocationSuccess extends MapState {
  final Position position;
  GetLocationSuccess(this.position);
}

final class GetLocationFailed extends MapState {}

final class UpdateCurrentPosition extends MapState {}

final class CalculateDistanceFailed extends MapState {}

final class CalculateDistanceSuccess extends MapState {
  final BranchEntities selectedBranch;
  CalculateDistanceSuccess(this.selectedBranch);
}
