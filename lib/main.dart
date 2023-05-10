import 'package:flutter/material.dart';
import 'package:numbers_app/Screens/SplashScreen/splashScreen.dart';
import 'package:numbers_app/Screens/HomePage/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashScreen.gradient(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Color.fromARGB(255, 66, 22, 141),
            Colors.deepPurple,
            Color.fromARGB(255, 178, 141, 241),
          ],
        ),
        duration: const Duration(seconds: 2),
        nextPage: const HomeScreen(),
        iconBackgroundColor: Colors.white,
        circleHeight: 60,
        child: Icon(
          Icons.numbers,
          size: 50,
        ),
        text: const Text(
          "Numbers App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
