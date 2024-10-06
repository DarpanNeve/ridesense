import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ridesense/core/api.dart';
import 'package:ridesense/features/location/data/models/location_model.dart';

class LocationRemoteDataSource {
  LocationRemoteDataSource() {
    dio.interceptors.add(PrettyDioLogger());
  }

  final dio = Dio();

  Future<PlacesResponse> fetchLocation(String location) async {
    final response = await dio.post(
      'https://places.googleapis.com/v1/places:searchText',
      options: Options(
        headers: {
          "X-Goog-Api-Key": mapApi,
          "X-Goog-FieldMask": "places.location",
          "Content-Type": "application/json",
        },
      ),
      queryParameters: {
        "textQuery": location,
      },
    );
    if (response.statusCode == 200) {
      PlacesResponse placesResponse = PlacesResponse.fromJson(response.data);
      return placesResponse;
    } else {
      throw Exception('Failed to fetch location');
    }
  }
}
