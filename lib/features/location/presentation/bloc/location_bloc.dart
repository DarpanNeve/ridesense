import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ridesense/features/location/data/repositories/location_repository_impl.dart';
import 'package:ridesense/features/location/presentation/bloc/location_event.dart';
import 'package:ridesense/features/location/presentation/bloc/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepositoryImpl locationRepository = LocationRepositoryImpl();

  LocationBloc() : super(LocationInputState()) {
    // Handle location input event
    on<InputLocationEvent>((event, emit) async {
      emit(LocationLoadingState());
      try {
        // Convert location input to latitude and longitude using geocoding (or other APIs)

        if (event.location.isNotEmpty) {
          final response = await locationRepository.getLocation(event.location);
          emit(LocationLoadedState(
              latitude: response.latitude, longitude: response.longitude));
          // emit(LocationLoadedState(
          //     latitude: event.location, longitude: location.longitude));
        } else {
          emit(const LocationErrorState('empty location'));
        }
      } catch (e) {
        emit(const LocationErrorState('Failed to fetch location.'));
      }
    });

    // Handle map display event
    on<ShowLocationOnMapEvent>((event, emit) {
      emit(LocationLoadedState(
          latitude: event.latitude, longitude: event.longitude));
    });
  }
}
