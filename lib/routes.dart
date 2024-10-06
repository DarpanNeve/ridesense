import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridesense/features/location/presentation/screen/location_input_screen.dart';
import 'package:ridesense/features/location/presentation/screen/location_map_screen.dart';

import 'features/location/data/models/location_model.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LocationInputScreen(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) {
        // Retrieve arguments (location data) passed via GoRouter
        final locationData = state.extra as Map<String, dynamic>?;
        return LocationMapScreen(
          location: MapLocation(
              latitude: locationData?['latitude'],
              longitude: locationData?['longitude']),
          // latitude: locationData?['latitude'],
          // longitude: locationData?['longitude'],
        );
      },
    ),
  ],
);
