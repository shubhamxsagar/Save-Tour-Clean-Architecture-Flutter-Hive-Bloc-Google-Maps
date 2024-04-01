part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object?> get props => [];
}

final class GeolocationLoading extends GeolocationState {}

final class GeolocationLoaded extends GeolocationState {
  final Position position;

  GeolocationLoaded({required this.position});

  @override
  List<Object> get props => [position];
}

final class GeolocationError extends GeolocationState {}
