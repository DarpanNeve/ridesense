// lib/ui/location_map_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:ridesense/features/map/bloc/map_bloc.dart';
import 'package:ridesense/features/map/bloc/map_event.dart';

import '../../../map/bloc/map_state.dart';
import '../../data/models/location_model.dart';

class LocationMapWidget extends StatelessWidget {
  const LocationMapWidget({super.key, required this.mapLocation});

  final MapLocation mapLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              context.read<MapBloc>().add(SwitchMapTypeEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is MapInitial) {
            // Trigger the location detection when the widget is initialized
            context.read<MapBloc>().add(DetectLocationEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is MapLocationLoaded) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: state.location,
                zoom: 12,
              ),
              mapType: state.mapType,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: {
                Marker(
                  markerId: const MarkerId('location_marker'),
                  position: LatLng(mapLocation.latitude, mapLocation.longitude),
                ),
              },
            );
          } else if (state is MapLocationError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
