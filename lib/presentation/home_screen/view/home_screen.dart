import 'package:flutter/material.dart';
import 'package:weather_report/presentation/home_screen/models/weather_model.dart';
import 'package:weather_report/service/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _weatherService = WeatherService();
  Weather? _weather;

  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final weather = await _weatherService.getWeather('Grozny');
    setState(() {
      _weather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _weather?.cityName ?? "loading city",
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
            iconSize: 30,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_weather?.temperature.round()}°C',
                  style: const TextStyle(
                      fontSize: 60, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text(
            '${_weather?.minTemp.round()}°C',
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Image.network(
//             "http:${_weather!.mainCondition}",
//           ),