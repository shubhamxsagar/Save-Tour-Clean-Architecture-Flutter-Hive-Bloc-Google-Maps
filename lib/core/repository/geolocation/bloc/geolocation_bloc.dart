import 'dart:async';

import 'package:arpan/core/repository/geolocation/geolocation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepository _geolocationRepository;
  StreamSubscription? _geolocationSubscription;
  GeolocationBloc({required GeolocationRepository geolocationRepository})
      : _geolocationRepository = geolocationRepository,
        super(GeolocationLoading()) {
    on<LoadGeolocation>((event, emit) async {
      _geolocationSubscription?.cancel();
      final LocationPermission permission =
          await _geolocationRepository.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Permission not granted, request it
        final LocationPermission newPermission =
            await _geolocationRepository.requestPermission();
        if (newPermission == LocationPermission.denied ||
            newPermission == LocationPermission.deniedForever) {
          // Permission still not granted, emit an error state
          emit(GeolocationError());
          return;
        }
      }
      // Permission granted, get location
      final Position position =
          await _geolocationRepository.getCurrentLocation();
      emit(GeolocationLoaded(position: position));
    });

    on<UpdateGeolocation>((event, emit) {
      emit(GeolocationLoaded(position: event.position));
    });
  }

  @override
  Future<void> close() {
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
