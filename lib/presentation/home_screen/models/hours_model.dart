class HourlyWeather {
  final String time;
  final double tempC;
  final String conditionText;

  HourlyWeather({
    required this.time,
    required this.tempC,
    required this.conditionText,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    String formattedTime = json['time'].split(' ')[1];
    return HourlyWeather(
      time: formattedTime,
      tempC: json['temp_c'],
      conditionText: json['condition']['text'],
    );
  }
}
