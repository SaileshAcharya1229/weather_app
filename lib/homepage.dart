import 'package:flutter/material.dart';
import 'package:weather_app/api.dart';
import 'package:weather_app/weathermodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiResponse? response;
  bool inProgress = false;
  String message = "search for the location to get weather data";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchWidget(),
            const SizedBox(
              height: 20,
            ),
            if (inProgress)
              CircularProgressIndicator()
            else
              Expanded(
                  child: SingleChildScrollView(child: _buildWeatherWidget())),
          ],
        ),
      ),
    ));
  }

  Widget _buildSearchWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
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

  Widget _buildWeatherWidget() {
    if (response == null) {
      return Text(message);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.location_on,
                size: 50,
              ),
              Text(
                response?.location?.name ?? "",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                response?.location?.country ?? "",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (response?.current?.tempC.toString() ?? "") + "°c",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                (response?.current?.condition?.text.toString() ?? ""),
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              height: 200,
              child: Image.network(
                "https:${response?.current?.condition?.icon}"
                    .replaceAll("64 x 64", "128 x 128"),
                scale: 0.7,
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("humidity",
                        response?.current?.humidity?.toString() ?? ""),
                    _dataAndTitleWidget(
                        "wind speed",
                        (response?.current?.windKph?.toString() ?? "") +
                            "km/h"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("humidity",
                        response?.current?.humidity?.toString() ?? ""),
                    _dataAndTitleWidget(
                        "wind speed",
                        (response?.current?.windKph?.toString() ?? "") +
                            "km/h"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget(
                        "UV", response?.current?.uv?.toString() ?? ""),
                    _dataAndTitleWidget("precipitation",
                        (response?.current?.precipMm?.toString() ?? "") + "mm"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("Local Time",
                        response?.location?.localtime?.split(" ").last ?? ""),
                    _dataAndTitleWidget("Long Date",
                        response?.location?.localtime?.split(" ").first ?? ""),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _dataAndTitleWidget(String title, String data) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            data,
            style: const TextStyle(
              fontSize: 27,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 27,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
    });

    try {
      ApiResponse response = await WeatherApi().getCurrentWeather(location);
      print(response.toJson());
    } catch (e) {
      setState(() {
        message = "failed to get weather";
        response = null;
      });
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}
