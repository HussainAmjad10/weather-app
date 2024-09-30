import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather.dart';

class WeatherService {
  static const _apiKey =
      'e03c640e32b28921ba8579e168617274'; // Use your OpenWeatherMap API key here
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather?> getWeather(String city) async {
    final response =
        await http.get(Uri.parse('$_baseUrl?q=$city&appid=$_apiKey'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      return null;
    }
  }
}
