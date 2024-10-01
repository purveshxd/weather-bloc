import 'package:bloc_05_weather_app/bloc/weather_bloc.dart';
import 'package:bloc_05_weather_app/data/data_provider/local_data_provider.dart';
import 'package:bloc_05_weather_app/data/data_provider/weather_data_provider.dart';
import 'package:bloc_05_weather_app/data/repository/weather_repository.dart';
import 'package:bloc_05_weather_app/presentation/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => WeatherRepository(WeatherDataProvider()),
        ),
        RepositoryProvider(
          create: (context) => LocalDataProvider(),
        ),
      ],
      child: BlocProvider(
        create: (context) => WeatherBloc(context.read<WeatherRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
          home: const Homescreen(),
        ),
      ),
    );
  }
}
