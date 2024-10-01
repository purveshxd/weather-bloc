import 'package:bloc_05_weather_app/data/repository/weather_repository.dart';
import 'package:bloc_05_weather_app/models/weather_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetched>(_getCurrentWeather);
  }

  void _getCurrentWeather(
      WeatherFetched event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      var cityName = "Nagpur";
      final weather =
          await weatherRepository.getCurrentWeather(cityName: cityName);
      return emit(WeatherSuccess(weatherModel: weather));
    } catch (e) {
      return emit(WeatherError(e.toString()));
    }
  }

  getSavedLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var cityName = prefs.getString("Location");
    return cityName;
  }
}
