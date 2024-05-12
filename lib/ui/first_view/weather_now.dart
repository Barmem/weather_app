import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';


class WeatherNowWidget extends StatefulWidget {
  final apiKey;
  final location;
  const WeatherNowWidget({
    required this.apiKey,
    required this.location,
    super.key
    });

  @override
  State<WeatherNowWidget> createState() => _WeatherNowWidgetState();
}

class _WeatherNowWidgetState extends State<WeatherNowWidget> {
  late String description;
  late String weatherImgUrl = '';
  late String temperature;
  late String feelsLike;
    @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String apiUrl = 'https://api.weatherapi.com/v1/current.json?key=${widget.apiKey}&lang=ru&q=';
    String location = widget.location;
    print(widget.apiKey);
    print(location);
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      location = "${position.latitude},${position.longitude}";
    } catch (e) {
      // print('Error fetching location: $e');
    }
    try {


      final response = await http.get(Uri.parse(apiUrl + location));
      final data = json.decode(utf8.decode(response.bodyBytes));

      setState(() {
        description = data['current']['condition']['text'];
        weatherImgUrl = "https:" + data['current']['condition']['icon'].replaceAll('64x64', '128x128');
        temperature = '${data['current']['temp_c']}°C';
        feelsLike = "Ощущается как " + data['current']['feelslike_c'].toString() + '°C';
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return weatherImgUrl.isNotEmpty && temperature.isNotEmpty && feelsLike.isNotEmpty && description.isNotEmpty
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description, style: const TextStyle( fontSize: 20)),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(weatherImgUrl),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(temperature, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
                      Text(feelsLike, style: const TextStyle( fontSize: 20)),
                    ],
                  ),
                ],
              ),
          ],
        )
        : const CircularProgressIndicator(); // Show a loading indicator while data is being fetched
  }
}