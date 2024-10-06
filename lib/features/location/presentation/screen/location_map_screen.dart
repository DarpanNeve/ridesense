import 'package:flutter/material.dart';
import 'package:ridesense/features/location/presentation/widget/location_map_widget.dart';

import '../../data/models/location_model.dart';

class LocationMapScreen extends StatelessWidget {
  const LocationMapScreen({super.key, required this.location});

  final MapLocation location;

  @override
  Widget build(BuildContext context) {
    // Get the arguments passed from the previous screen (latitude and longitude)
    return Scaffold(
      body: LocationMapWidget(mapLocation: location),
    );
  }
}
