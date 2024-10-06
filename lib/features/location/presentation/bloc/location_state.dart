import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInputState extends LocationState {}

class LocationLoadingState extends LocationState {}

class LocationLoadedState extends LocationState {
  final double latitude;
  final double longitude;

  const LocationLoadedState({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}

class LocationErrorState extends LocationState {
  final String message;

  const LocationErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
