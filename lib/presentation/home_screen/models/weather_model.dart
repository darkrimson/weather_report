import 'package:weather_report/presentation/home_screen/models/hours_model.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double maxTemp;
  final double minTemp;
  final List<HourlyWeather> hourlyWeather;

  Weather({
    required this.maxTemp,
    required this.minTemp,
    required this.cityName,
    required this.mainCondition,
    required this.temperature,
    required this.hourlyWeather,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    List<HourlyWeather> hourlyWeather =
        (json['forecast']['forecastday'][0]['hour'] as List)
            .map((i) => HourlyWeather.fromJson(i))
            .toList();
    return Weather(
      cityName: json['location']['name'],
      mainCondition: json['current']['condition']['text'],
      temperature: json['current']['temp_c'],
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      hourlyWeather: hourlyWeather,
    );
  }
}
