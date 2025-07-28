import 'package:fitvault/views/bmi_calculator/bmi_calculator_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF283593), // Deep Blue
        colorScheme:
            ColorScheme.fromSwatch(
              primarySwatch: Colors.indigo,
              accentColor: Color(0xFF6A1B9A), // Indigo/Purple
              backgroundColor: Color(0xFFF3F3FC), // Very light purple
            ).copyWith(
              secondary: Color(0xFF6A1B9A),
              surface: Color(0xFFF3F3FC),
              brightness: Brightness.light,
            ),
        scaffoldBackgroundColor: Color(0xFFF3F3FC),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF283593),
          foregroundColor: Colors.white,
          elevation: 4.0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF6A1B9A),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF283593),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: BMICalculatorView(),
    );
  }
}


