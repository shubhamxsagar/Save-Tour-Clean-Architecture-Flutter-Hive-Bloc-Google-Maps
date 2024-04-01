part of 'current_location_bloc.dart';

class CurrentLocationState extends Equatable {
  LatLng currentLocation;
  CurrentLocationState({this.currentLocation = const LatLng(0, 0)});

  CurrentLocationState copyWith({LatLng? currentLocation}) {
    return CurrentLocationState(
        currentLocation: currentLocation ?? this.currentLocation);
  }

  @override
  List<Object> get props => [currentLocation];
}

