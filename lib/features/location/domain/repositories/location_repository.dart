import 'package:ridesense/features/location/data/models/location_model.dart';

abstract interface class LocationRepository {
  Future<MapLocation> getLocation(String location);
}
