// lib/bloc/map_state.dart
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLocationLoaded extends MapState {
  final LatLng location;
  final MapType mapType;

  MapLocationLoaded({required this.location, required this.mapType});

  @override
  List<Object?> get props => [location, mapType];
}

class MapLocationError extends MapState {
  final String message;

  MapLocationError({required this.message});

  @override
  List<Object?> get props => [message];
}
