// lib/bloc/map_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  Location _location = Location();
  MapType _currentMapType = MapType.normal;

  MapBloc() : super(MapInitial()) {
    on<DetectLocationEvent>(_onDetectLocation);
    on<SwitchMapTypeEvent>(_onSwitchMapType);
  }

  Future<void> _onDetectLocation(
      DetectLocationEvent event, Emitter<MapState> emit) async {
    try {
      bool _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) {
          emit(MapLocationError(message: "Location services disabled."));
          return;
        }
      }

      PermissionStatus _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          emit(MapLocationError(message: "Location permission denied."));
          return;
        }
      }

      LocationData _locationData = await _location.getLocation();
      LatLng currentLocation =
          LatLng(_locationData.latitude!, _locationData.longitude!);

      emit(MapLocationLoaded(
          location: currentLocation, mapType: _currentMapType));
    } catch (e) {
      emit(MapLocationError(message: e.toString()));
    }
  }

  void _onSwitchMapType(SwitchMapTypeEvent event, Emitter<MapState> emit) {
    _currentMapType = _currentMapType == MapType.normal
        ? MapType.satellite
        : _currentMapType == MapType.satellite
            ? MapType.terrain
            : _currentMapType == MapType.terrain
                ? MapType.hybrid
                : MapType.normal;

    if (state is MapLocationLoaded) {
      final currentState = state as MapLocationLoaded;
      emit(MapLocationLoaded(
          location: currentState.location, mapType: _currentMapType));
    }
  }
}
