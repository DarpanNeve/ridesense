import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ridesense/features/location/presentation/bloc/location_bloc.dart';
import 'package:ridesense/features/location/presentation/bloc/location_event.dart';
import 'package:ridesense/features/location/presentation/bloc/location_state.dart';

class LocationInputScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  LocationInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Location')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<LocationBloc, LocationState>(
              listener: (context, state) {
                if (state is LocationErrorState) {
                  // Show error message
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
                if (state is LocationLoadedState) {
                  // Navigate to map screen on success
                  context.go('/map', extra: {
                    'latitude': state.latitude,
                    'longitude': state.longitude,
                  });
                }
              },
              builder: (context, state) {
                if (state is LocationErrorState) {
                  return Text(state.message);
                } else if (state is LocationLoadingState) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    final location = _controller.text;
                    if (location.isNotEmpty) {
                      // Dispatch the event to get the location (via Bloc)
                      BlocProvider.of<LocationBloc>(context)
                          .add(InputLocationEvent(location));

                      // Navigate to the Map screen with the location data after getting state
                      BlocListener<LocationBloc, LocationState>(
                        listener: (context, state) {
                          if (state is LocationLoadedState) {
                            context.go('/map', extra: {
                              'latitude': state.latitude,
                              'longitude': state.longitude,
                            });
                          }
                        },
                      );
                    } else {
                      // Show validation error
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please enter a location'),
                      ));
                    }
                  },
                  child: const Text('Submit'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
