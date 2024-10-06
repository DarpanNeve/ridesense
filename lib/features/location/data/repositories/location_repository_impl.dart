import 'package:ridesense/features/location/data/datasource/location_remote_data_source.dart';
import 'package:ridesense/features/location/data/models/location_model.dart';

import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource locationRemoteDataSource =
      LocationRemoteDataSource();

  @override
  Future<MapLocation> getLocation(String location) async {
    try {
      PlacesResponse placesResponse =
          await locationRemoteDataSource.fetchLocation(location);
      return placesResponse.places[0].location;
    } catch (e) {
      throw Exception('Failed to fetch location');
    }
  }
}
