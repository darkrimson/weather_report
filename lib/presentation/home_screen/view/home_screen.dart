import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

  String getConditionImage(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'night':
        return 'assets/Rainny_Night.json';
      case 'mist':
      case 'smoke':
      case 'fog':
      case 'overcast':
      case 'clouds':
        return 'assets/cloude.json';
      case 'snow':
        return 'assets/snow.json';
      case 'clear':
        return 'assets/cloude.json';
      case 'rain':
        return 'assets/storm.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(202, 236, 254, 18),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Text(
            _weather?.cityName ?? "loading city",
            style: const TextStyle(
              fontSize: 30,
              fontFamily: 'PingFang',
              fontWeight: FontWeight.w500,
              height: 0.06,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded),
              iconSize: 30,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 25),
              Container(
                width: 250,
                height: 250,
                child: Lottie.asset(getConditionImage(_weather?.mainCondition)),
              ),
              Text(
                '${_weather?.mainCondition}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF1D2837),
                  fontSize: 28,
                  fontFamily: 'PingFang',
                  fontWeight: FontWeight.w400,
                  height: 0.03,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                '${_weather?.temperature.round()}°',
                style: const TextStyle(
                  fontSize: 48,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w900,
                  height: 0,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_weather?.maxTemp.round()}°',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'PingFang',
                    ),
                  ),
                  Text(
                    '| ${_weather?.minTemp.round()}° ',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'PingFang',
                    ),
                  ),
                ],
              ),
            ],
          ),
          list_view_hours(),
        ],
      ),
    );
  }

  Container list_view_hours() {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _weather?.hourlyWeather.length ?? 0,
        itemBuilder: (context, index) {
          var hourlyWeather = _weather?.hourlyWeather[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  Text(
                    hourlyWeather?.time ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF737A83),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'PingFang',
                    ),
                  ),
                  Lottie.asset(getConditionImage(hourlyWeather?.conditionText),
                      width: 64, height: 64),
                  Text(
                    '${hourlyWeather?.tempC.round()}°',
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      color: Color(0xFF737A83),
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
