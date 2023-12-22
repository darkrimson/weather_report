import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_report/presentation/home_screen/models/weather_model.dart';

class WeatherService {
  static const BASE_URL =
      'http://api.weatherapi.com/v1/forecast.json?key=a3d7069fc3c4407f912120532231012&q=';

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$cityName&days=2&aqi=no&alerts=no'),
    );
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<String> getCurrentCity() async {
    //Проверка на разрешение
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //Точность местоположения
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    //Нахождение ширины и долготы
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    //Получение названия города
    String? city = placemarks[0].locality;

    return city ?? "";
  }
}
