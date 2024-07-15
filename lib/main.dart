import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/provider/whether_provider.dart';
import 'package:wheather_app/views/homepage/homepage.dart';
import 'package:wheather_app/views/splash_screen/splash_screen_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WhetherProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(
              weatherProvider: WhetherProvider(),
            ),
        "/home": (context) => const Homepage(),
        // "home":(context) => home_screen(),
        //"serach":(context) => WeatherScreen(),
      },
    );
  }
}
