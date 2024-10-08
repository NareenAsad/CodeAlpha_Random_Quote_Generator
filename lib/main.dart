import 'package:flutter/material.dart';
import 'package:random_quote_generator/screens/random_quote_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Quote Generator',
      debugShowCheckedModeBanner: false,
      home: RandomQuoteScreen(),
    );
  }
}
