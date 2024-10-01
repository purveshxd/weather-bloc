import 'dart:developer';

import 'package:bloc_05_weather_app/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    context.read<WeatherBloc>().add(WeatherFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Map of weather emojis to their descriptions
    final Map<String, String> weatherIcons = {
      '☁️': 'clouds',
      '⛅': 'partly cloudy',
      '⛈️': 'thunderstorm',
      '🌤️': 'sun with cloud',
      '🌥️': 'cloudy',
      '🌦️': 'sun rain',
      '🌧️': 'rain',
      '🌨️': 'snow',
      '🌩️': 'lightning',
      '☀️': 'sun clear',
    };
    String getIcons(String searchIcon) {
      log("From API == $searchIcon");
      String displayIcon = '';
      for (var i = 0; i < weatherIcons.length; i++) {
        if (weatherIcons.values
            .elementAt(i)
            .contains(searchIcon.toLowerCase())) {
          log('from search=${weatherIcons.values.elementAt(i)}');
          log(weatherIcons.keys.elementAt(i));
          displayIcon = weatherIcons.keys.elementAt(i);
        }
      }

      // log(displayIcon);
      return displayIcon;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context.read<WeatherBloc>().add(WeatherFetched());
              },
              icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherError) {
            return Center(child: Text(state.error));
          }
          if (state is! WeatherSuccess) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          state.weatherModel.weatherDes[0].toUpperCase() +
                              state.weatherModel.weatherDes.substring(1),
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.075,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.weatherModel.currentTemp
                                  .toString()
                                  .split('.')[0],
                              style: TextStyle(
                                  height: 1,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.31,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ),
                            Text(
                              getIcons(
                                  state.weatherModel.currentSky.toString()),
                              textScaler: TextScaler.linear(
                                  MediaQuery.of(context).size.width * 0.013),
                            ),
                          ],
                        ),
                        Chip(
                          shape: const StadiumBorder(),
                          elevation: 0,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          side: BorderSide.none,
                          label: Text(
                            "Feels like ${state.weatherModel.feelsLike.toString().split('.')[0]}°C",
                            textScaler: TextScaler.linear(
                                MediaQuery.of(context).size.width * 0.0032),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox.square(
                        dimension: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, bottom: 8),
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.errorContainer,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.air_rounded,
                                  size:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                Text(
                                  'Wind',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer),
                                ),
                                Text(
                                  '${state.weatherModel.currendWindSpeed} km/h',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox.square(
                        dimension: MediaQuery.of(context).size.width * 0.5,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Theme.of(context).colorScheme.onSurface,
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.water_drop_rounded,
                                  size:
                                      MediaQuery.of(context).size.width * 0.07,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                Text(
                                  "Humidity",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onInverseSurface),
                                ),
                                const Spacer(),
                                Text(
                                  '${state.weatherModel.currentHumidity}%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onInverseSurface),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
