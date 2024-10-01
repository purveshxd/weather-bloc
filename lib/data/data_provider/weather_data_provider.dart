import 'package:bloc_05_weather_app/secrets.dart';
import 'package:http/http.dart' as http;

class WeatherDataProvider {
  Future<String> getCurrentWeathr(String cityName) async {
    try {
      // cityName = 'Nagpur';
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$SECRET_API_KEY&units=metric"));
      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
