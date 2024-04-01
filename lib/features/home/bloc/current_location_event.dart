part of 'current_location_bloc.dart';

sealed class CurrentLocationEvent extends Equatable {
  const CurrentLocationEvent();

  @override
  List<Object> get props => [];
}

class GetTheCurrentLocation extends CurrentLocationEvent {
  final LatLng currentLocation;

  GetTheCurrentLocation(this.currentLocation);

  @override
  List<Object> get props => [currentLocation];
}