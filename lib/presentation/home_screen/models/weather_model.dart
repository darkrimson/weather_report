class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  // final double maxTemp;
  final double minTemp;

  Weather({
    // required this.maxTemp,
    required this.minTemp,
    required this.cityName,
    required this.mainCondition,
    required this.temperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['name'],
      mainCondition: json['current']['condition']['icon'],
      temperature: json['current']['temp_c'],
      // maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
    );
  }
}
