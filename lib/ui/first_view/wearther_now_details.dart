import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:geolocator/geolocator.dart';

const windSpeedIcon = "assets/weather_icons/wind.png";
const humidityIcon = "assets/weather_icons/drop.png";
const pressureIcon = "assets/weather_icons/thermometer-1.png";

class WeatherNowDetailsWidget extends StatefulWidget {
  final apiKey;
  final location;
  const WeatherNowDetailsWidget({
    required this.apiKey,
    required this.location,
    super.key
});
  
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
    String apiUrl = 'https://api.weatherapi.com/v1/current.json?key=${widget.apiKey}&lang=ru&q=';
    String location = widget.location;
    // try {
    //   Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.low,
    //   );
    //   location = "${position.latitude},${position.longitude}";
    // } catch (e) {
    //   print('Error fetching location: $e');
    // }
    try {


      final response = await http.get(Uri.parse(apiUrl + location));
      final data = json.decode(utf8.decode(response.bodyBytes));

      setState(() {
        windSpeed = "Скорость ветра ${(data['current']['wind_kph'] * 0.2777).floor()}-${(data['current']['wind_kph'] * 0.2777).ceil()} м/с";
        humidity = "Влажность ${data['current']['humidity']}%";
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
                  const Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Image(
                      width: 32,
                      height: 32,
                      image: AssetImage(windSpeedIcon),
                    ),
                  ),
                  Text(windSpeed),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Image(
                      width: 32,
                      height: 32,
                      image: AssetImage(humidityIcon),
                    ),
                  ),
                  Text(humidity),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Image(
                      width: 32,
                      height: 32,
                      image: AssetImage(pressureIcon),
                    ),
                  ),
                  Text(pressure),
                ],
              ),
            ),
          ],
        )
        : const Center(child: CircularProgressIndicator()); // Show a loading indicator while data is being fetched
  }
}