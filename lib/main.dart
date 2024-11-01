import 'package:bitcoin_ticker/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BitcoinTickerApp());
}

class BitcoinTickerApp extends StatelessWidget {
  const BitcoinTickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
