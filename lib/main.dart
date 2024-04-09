import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/ui/pageview_block.dart';
import 'package:weather_app/ui/first_view/weather_now.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: PageViewWithText(title: "Сейчас", viewHeight: 224, firstView: Center(child: WeatherNowWidget()), secondView: Container(color: Colors.red, height: 200,),),
        ),
      ),
    );
  }
}