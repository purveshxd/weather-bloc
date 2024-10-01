// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {
  final double currentTemp;
  final String currentSky;
  final int currentPressure;
  final double currendWindSpeed;
  final int currentHumidity;
  final String iconCode;
  final double feelsLike;
  final String weatherDes;
  WeatherModel({
    required this.weatherDes,
    required this.feelsLike,
    required this.iconCode,
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currendWindSpeed,
    required this.currentHumidity,
  });

  WeatherModel copyWith({
    double? currentTemp,
    String? currentSky,
    int? currentPressure,
    double? currendWindSpeed,
    int? currentHumidity,
    String? iconCode,
    double? feelsLike,
    String? weatherDes,
  }) {
    return WeatherModel(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currendWindSpeed: currendWindSpeed ?? this.currendWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity,
      iconCode: iconCode ?? this.iconCode,
      feelsLike: feelsLike ?? this.feelsLike,
      weatherDes: weatherDes ?? this.weatherDes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'iconCode': iconCode,
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currendWindSpeed': currendWindSpeed,
      'currentHumidity': currentHumidity,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];

    return WeatherModel(
      feelsLike: currentWeatherData['main']['feels_like'] as double,
      weatherDes: currentWeatherData['weather'][0]['description'],
      currentTemp: currentWeatherData['main']['temp'] as double,
      currentSky: currentWeatherData['weather'][0]['main'],
      currentPressure: currentWeatherData['main']['pressure'],
      currendWindSpeed: currentWeatherData['wind']['speed'] as double,
      currentHumidity: currentWeatherData['main']['humidity'],
      iconCode: currentWeatherData['weather'][0]['icon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currendWindSpeed: $currendWindSpeed, currentHumidity: $currentHumidity, iconCode: $iconCode)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currendWindSpeed == currendWindSpeed &&
        other.currentHumidity == currentHumidity &&
        other.iconCode == iconCode;
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currendWindSpeed.hashCode ^
        currentHumidity.hashCode ^
        iconCode.hashCode;
  }
}
