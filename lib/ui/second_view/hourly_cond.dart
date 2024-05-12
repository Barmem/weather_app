import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/ui/second_view/draw_block.dart';
import 'dart:math' as math;

class HourlyWeatherWidget extends StatefulWidget {
  final String apiKey;
  final String location;

  const HourlyWeatherWidget({
    super.key,
    required this.apiKey,
    required this.location,
  });

  @override
  _HourlyWeatherWidgetState createState() => _HourlyWeatherWidgetState();
}

class _HourlyWeatherWidgetState extends State<HourlyWeatherWidget> {
  List<double> hourlyTemps = [];
  List<String> hourlyConditions = [];
  List<String> hourCount = [];
  List<double> normalized = [];

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final apiUrl =
        'http://api.weatherapi.com/v1/forecast.json?key=${widget.apiKey}&q=${widget.location}&days=2&aqi=no&alerts=no';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final responseData = json.decode(response.body);

      List forecast = responseData['forecast']['forecastday'][0]['hour'] + responseData['forecast']['forecastday'][1]['hour'];
      
      DateTime now = DateTime.now();
      int timestamp = now.millisecondsSinceEpoch;
      timestamp = timestamp ~/ 1000;
      for (var hour in forecast) {
        int epoch = hour['time_epoch'];
        if (epoch < timestamp) { 
        continue;
        }
        if (epoch > timestamp + 86400) {
          break;
        }
        double tempC = hour['temp_c'];
        String condition = "https:" + hour['condition']['icon'];
        String hourC = hour['time'].replaceAll(RegExp(r'^[^ ]+ '), '');
        hourlyTemps.add(tempC);
        hourlyConditions.add(condition);
        hourCount.add(hourC);
      }
      double minTemp = hourlyTemps.reduce(math.min);
      double maxTemp = hourlyTemps.reduce(math.max);

      normalized = hourlyTemps.map((temp) => (temp - minTemp) / (maxTemp - minTemp)).toList();

      setState(() {});
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return hourlyTemps.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            
            child: Row(
              children: List.generate(hourlyTemps.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomBlockWidget(topText: '${hourlyTemps[index]}°C', height: normalized[index].clamp(0, 1) * 70 + 30, width: 60, image: hourlyConditions[index], bottomText: hourCount[index],)
                );
              }),
            ),
          );
  }
}
