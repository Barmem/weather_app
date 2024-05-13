import 'package:flutter/material.dart';
import 'package:weather_app/ui/first_view/wearther_now_details.dart';
import 'package:weather_app/ui/pageview_block.dart';
import 'package:weather_app/ui/first_view/weather_now.dart';
import 'package:weather_app/ui/second_view/hourly_cond.dart';
import 'package:weather_app/ui/third_view/daily_cond.dart';

const apiKey = String.fromEnvironment('API_KEY', defaultValue: '');
const location = String.fromEnvironment('LOCATION', defaultValue: '');
const nowWeatherTitle = "Сейчас";
const todayWeatherTitle = "Сегодня";
const weekWeatherTitle = "Неделя";
const double nowWeatherheight = 224;
const double todayWeatherheight = 224;
const double weekWeatherheight = 600;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ListView(
      children: const [
        PageViewWithText(
          title: nowWeatherTitle,
          viewHeight: nowWeatherheight,
          views: [
            Center(
                child: WeatherNowWidget(
              apiKey: apiKey,
              location: location,
            )),
            WeatherNowDetailsWidget(
              apiKey: apiKey,
              location: location,
            ),
          ],
        ),
        PageViewWithText(
          title: todayWeatherTitle,
          viewHeight: todayWeatherheight,
          views: [
            HourlyWeatherWidget(
              apiKey: apiKey,
              location: location,
            ),
          ],
        ),
        PageViewWithText(
          title: weekWeatherTitle,
          viewHeight: weekWeatherheight,
          views: [
            DailyWeatherWidget(
              apiKey: apiKey,
              location: location,
            ),
          ],
        ),
      ],
    ),
    const PlaceholderPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Info",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Info Placeholder Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
