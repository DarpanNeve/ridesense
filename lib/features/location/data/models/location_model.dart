class MapLocation {
  double latitude;
  double longitude;

  MapLocation({
    required this.latitude,
    required this.longitude,
  });

  // Factory method to create Location object from JSON
  factory MapLocation.fromJson(Map<String, dynamic> json) {
    return MapLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  // Method to convert Location object to JSON
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class Place {
  MapLocation location;

  Place({
    required this.location,
  });

  // Factory method to create Place object from JSON
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      location: MapLocation.fromJson(json['location']),
    );
  }

  // Method to convert Place object to JSON
  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
    };
  }
}

class PlacesResponse {
  List<Place> places;

  PlacesResponse({
    required this.places,
  });

  // Factory method to create PlacesResponse object from JSON
  factory PlacesResponse.fromJson(Map<String, dynamic> json) {
    var placesList = json['places'] as List;
    List<Place> places = placesList.map((i) => Place.fromJson(i)).toList();

    return PlacesResponse(
      places: places,
    );
  }

  // Method to convert PlacesResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'places': places.map((place) => place.toJson()).toList(),
    };
  }
}
