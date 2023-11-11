import 'package:flutter/material.dart';
import 'package:to_do_list_dev/app/presentation/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
              color: Colors.white, fontFamily: 'LTWave', fontSize: 22),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff011c26)),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
              color: Colors.white, fontFamily: 'LTWave', fontSize: 22),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xff011c26),
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      home: const HomePage(),
    );
  }
}
