import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';


class WeatherNowDetailsWidget extends StatefulWidget {
  const WeatherNowDetailsWidget({super.key});

  @override
  State<WeatherNowDetailsWidget> createState() => _WeatherNowDetailsWidgetState();
}

class _WeatherNowDetailsWidgetState extends State<WeatherNowDetailsWidget> {

  late String windSpeed;
  late String humidity = '';
  late String pressure;
  late String feelsLike;
    @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Make sure to replace 'YOUR_API_KEY' with your actual WeatherAPI.com API key
    String apiKey = '***REMOVED***';
    String apiUrl = 'https://api.weatherapi.com/v1/current.json?key=$apiKey&lang=ru&q=';
    String location = 'Omsk';
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      location = position.latitude.toString() + "," + position.longitude.toString();
    } catch (e) {
      print('Error fetching location: $e');
    }
    try {


      final response = await http.get(Uri.parse(apiUrl + location));
      final data = json.decode(utf8.decode(response.bodyBytes));

      setState(() {
        windSpeed = "Скорость ветра " + (data['current']['wind_kph'] * 0.2777).floor().toString() + "-" + (data['current']['wind_kph'] * 0.2777).ceil().toString() + " м/с";
        humidity = "Влажность " + data['current']['humidity'].toString() + "%";
        pressure = "Давление " + data['current']['pressure_mb'].toString() + ' милибар';
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return humidity.isNotEmpty && pressure.isNotEmpty && windSpeed.isNotEmpty
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image(
                    width: 32,
                    height: 32,
                    image: AssetImage("assets/weather_icons/wind.png"),
                  ),
                  Text(windSpeed),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image(
                    width: 32,
                    height: 32,
                    image: AssetImage("assets/weather_icons/drop.png"),
                  ),
                  Text(humidity),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image(
                    width: 32,
                    height: 32,
                    image: AssetImage("assets/weather_icons/thermometer-1.png"),
                  ),
                  Text(pressure),
                ],
              ),
            ),
          ],
        )
        : Center(child: CircularProgressIndicator()); // Show a loading indicator while data is being fetched
  }
}