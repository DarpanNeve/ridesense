import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridesense/features/location/presentation/bloc/location_bloc.dart';
import 'package:ridesense/features/map/bloc/map_bloc.dart';
import 'package:ridesense/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc(),
        ),
        BlocProvider<MapBloc>(
          create: (context) => MapBloc(),
        )
      ],
      // Providing the LocationBloc to the widget tree
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Location App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router,
      ),
    );
  }
}
