import 'package:flutter/material.dart';
import 'package:app_play_store_games/pages/homepage.dart';
import 'package:app_play_store_games/pages/gamepage.dart';
import 'package:app_play_store_games/pages/filterpage.dart';
import 'package:app_play_store_games/services/gps_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Play Games',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => GpsService(),
        '/home': (context) => HomePage(),
        '/game': (context) => GamePage(),
        '/filters': (context) => FilterPage(),
      },
    );
  }
}
