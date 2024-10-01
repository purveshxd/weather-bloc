import 'dart:convert';

import 'package:bloc_05_weather_app/data/data_provider/weather_data_provider.dart';
import 'package:bloc_05_weather_app/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;

  WeatherRepository(this.weatherDataProvider);
  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      final weatherData = await weatherDataProvider.getCurrentWeathr(cityName);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw "An unexpedted error occured! Try again later";
      }
      // log(jsonEncode(data['list']));
      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
