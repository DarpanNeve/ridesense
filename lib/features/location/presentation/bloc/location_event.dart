import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Abstract class for all location-related events
abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

// Event for when the user inputs a location
class InputLocationEvent extends LocationEvent {
  final String location;

  const InputLocationEvent(this.location);

  @override
  List<Object?> get props => [location];
}

// Event for when the user wants to display the location on the map
class ShowLocationOnMapEvent extends LocationEvent {
  final double latitude;
  final double longitude;

  const ShowLocationOnMapEvent(
      {required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
