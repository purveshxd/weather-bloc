part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherModel weatherModel;

  WeatherSuccess({required this.weatherModel});
}

final class WeatherError extends WeatherState {
  final String error;

  WeatherError(this.error);
}

final class WeatherLoading extends WeatherState {}

final class WeatherLocation extends WeatherState {
  final String location;

  WeatherLocation(this.location);
}
