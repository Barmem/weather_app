import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/ui/third_view/draw_block_vertical.dart';
import 'dart:math' as math;

class DailyWeatherWidget extends StatefulWidget {
  final String apiKey;
  final String location;

  const DailyWeatherWidget({
    super.key,
    required this.apiKey,
    required this.location,
  });

  @override
  _DailyWeatherWidgetState createState() => _DailyWeatherWidgetState();
}

class _DailyWeatherWidgetState extends State<DailyWeatherWidget> {
  List<double> dailyMaxTemps = [];
  List<double> dailyMinTemps = [];
  List<String> dailyConditions = [];
  List<double> dailyRain = [];
  List<String> weekDayCount = [];
  List<double> normalizedTempWidth = [];

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final apiUrl =
        'http://api.weatherapi.com/v1/forecast.json?key=${widget.apiKey}&q=${widget.location}&days=7&aqi=no&alerts=no';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final responseData = json.decode(response.body);

      List forecast = responseData['forecast']['forecastday'];
      
      
      for (var dayData in forecast) {

        double maxTempC = dayData['day']['maxtemp_c'];
        double minTempC = dayData['day']['mintemp_c'];
        String condition = "https:" + dayData['day']['condition']['icon'];
        int day = dayData['date_epoch'];
        int rain = dayData['day']['daily_chance_of_rain'];
        dailyMaxTemps.add(maxTempC);
        dailyMinTemps.add(minTempC);
        dailyConditions.add(condition);
        dailyRain.add(double.parse(rain.toString()));
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(day * 1000);

        String weekDay;
        switch (dateTime.weekday) {
          case 1: weekDay = "пн"; break;
          case 2: weekDay = "вт"; break;
          case 3: weekDay = "ср"; break;
          case 4: weekDay = "чт"; break;
          case 5: weekDay = "пт"; break;
          case 6: weekDay = "сб"; break;
          case 7: weekDay = "вс"; break;
          default: weekDay = "";
        }
        weekDayCount.add(weekDay);
      }
      double minTemp = dailyMaxTemps.reduce(math.min);
      double maxTemp = dailyMaxTemps.reduce(math.max);
      
      normalizedTempWidth = dailyMaxTemps.map((temp) => (temp - minTemp) / (maxTemp - minTemp)).toList();

      setState(() {});
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return dailyMaxTemps.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(dailyMaxTemps.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomBlockWidgetVertical(
                    heightLeft: 50,
                    widthLeft: dailyRain[index].clamp(45, 100),
                    maxTemp: '${dailyMaxTemps[index]}°C',
                    minTemp: '${dailyMinTemps[index]}°C',
                    heightRight: 50, 
                    widthRight: normalizedTempWidth[index].clamp(0, 1) * 70, 
                    image: dailyConditions[index], 
                    bottomText: weekDayCount[index],
                  ),
                );
              }),
            ),
          );
  }
}
