import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myapp2/weather_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(),
        ),
        home: const WeatherHomePage(),
      ),
    );
  }
}

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherModel = Provider.of<WeatherModel>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF73C8A9), // Cool gradient color
              Color(0xFF373B44),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Weather App',
              style: GoogleFonts.lato(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              onSubmitted: (city) {
                weatherModel.fetchWeather(city);
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                hintText: 'Enter city',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            weatherModel.isLoading
                ? const SpinKitWave(
                    color: Colors.white,
                    size: 50.0,
                  )
                : weatherModel.weatherData != null
                    ? WeatherDisplay(weatherModel: weatherModel)
                    : const Text(
                        'No data available',
                        style: TextStyle(color: Colors.white),
                      ),
          ],
        ),
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final WeatherModel weatherModel;
  const WeatherDisplay({Key? key, required this.weatherModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              weatherModel.weatherData!.temperature,
              style: GoogleFonts.lato(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              weatherModel.weatherData!.description,
              style: GoogleFonts.lato(
                fontSize: 24,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
            const Icon(
              Icons.wb_sunny, // Customize with weather-based icons
              size: 50,
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}
