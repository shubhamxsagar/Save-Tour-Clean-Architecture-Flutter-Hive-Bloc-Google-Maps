import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'current_location_event.dart';
part 'current_location_state.dart';

class CurrentLocationBloc
    extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  CurrentLocationBloc() : super(CurrentLocationState()) {
    on<GetTheCurrentLocation>(_getCurrentLocation);
  }
  void _getCurrentLocation(
      GetTheCurrentLocation event, Emitter<CurrentLocationState> emit) {
    emit(state.copyWith(currentLocation: event.currentLocation));
  }
}
