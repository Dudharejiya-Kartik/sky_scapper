import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wheather_app/views/homepage/homepage.dart';
import '../../provider/whether_provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key, required this.weatherProvider});

  WhetherProvider weatherProvider;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 10),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Homepage(),
          ),
        );
      },
    );
    return Scaffold(
      // body: (widget.weatherProvider.weather == null &&
      //         widget.weatherProvider.list.isEmpty)
      //     ? const Center(
      //         child: CircularProgressIndicator(),
      //       )
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.21, -0.98),
            end: Alignment(0.21, 0.98),
            colors: [
              Color(0xff142058),
              Color(0xff454DB7),
              Color(0xFF4A91FF),
              Color(0xFF47BFDF),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Image.asset(
              'assets/images/weather.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
