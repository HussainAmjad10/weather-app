class Weather {
  final String temperature;
  final String description;

  Weather({required this.temperature, required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: '${(json['main']['temp'] - 273.15).toStringAsFixed(1)} °C',
      description: json['weather'][0]['description'],
    );
  }
}
