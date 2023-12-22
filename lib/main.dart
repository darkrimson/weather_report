import 'package:flutter/material.dart';

import 'package:weather_report/presentation/home_screen/view/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather Report',
      home: HomeScreen(),
    );
  }
}
