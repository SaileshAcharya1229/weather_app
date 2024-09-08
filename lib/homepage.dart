import 'package:flutter/material.dart';
import 'package:weather_app/api.dart';
import 'package:weather_app/weathermodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [_buildSearchWidget()],
      ),
    )));
  }

  Widget _buildSearchWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search any location",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
        onSubmitted: (value) {
          _getWeatherData(value); // Handle the search query here
        },
      ),
    );
  }

  _getWeatherData(String location) async {
    ApiResponse response = WeatherApi().getCurrentWeather(location);
    print(response.toJson());
  }
}
