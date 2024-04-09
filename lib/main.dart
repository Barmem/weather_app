import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/ui/first_view/wearther_now_details.dart';
import 'package:weather_app/ui/pageview_block.dart';
import 'package:weather_app/ui/first_view/weather_now.dart';
import 'package:weather_app/ui/second_view/hourly_cond.dart';

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
            PageViewWithText(title: "Сейчас", viewHeight: 224, views: [ Center(child: WeatherNowWidget()), WeatherNowDetailsWidget() ] ),
            PageViewWithText(title: "Сегодня", viewHeight: 224, views: [ HourlyWeatherWidget( apiKey: '***REMOVED***', location: 'Omsk'), ] ),
          ],
        ),
      ),
    );
  }
}
