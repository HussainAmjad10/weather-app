import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'weather.dart';

class WeatherModel with ChangeNotifier {
  Weather? _weatherData;
  bool _isLoading = false;

  Weather? get weatherData => _weatherData;
  bool get isLoading => _isLoading;

  void fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    _weatherData = await WeatherService().getWeather(city);

    _isLoading = false;
    notifyListeners();
  }
}
