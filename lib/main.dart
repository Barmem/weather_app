import 'package:flutter/material.dart';
import 'package:weather_app/ui/first_view/wearther_now_details.dart';
import 'package:weather_app/ui/pageview_block.dart';
import 'package:weather_app/ui/first_view/weather_now.dart';
import 'package:weather_app/ui/second_view/hourly_cond.dart';
import 'package:weather_app/ui/third_view/daily_cond.dart';

const apiKey = String.fromEnvironment('API_KEY', defaultValue: '');
const location = String.fromEnvironment('LOCATION', defaultValue: '');
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            PageViewWithText(title: "Сейчас", viewHeight: 224, views: [ Center(child: WeatherNowWidget( apiKey: apiKey, location: location )), WeatherNowDetailsWidget( apiKey: apiKey, location: location ) ] ),
            PageViewWithText(title: "Сегодня", viewHeight: 224, views: [ HourlyWeatherWidget( apiKey: apiKey, location: location ), ] ),
            PageViewWithText(title: "Неделя", viewHeight: 600, views: [ DailyWeatherWidget( apiKey: apiKey, location: location ), ] ),
          ],
        ),
      ),
    );
  }
}
