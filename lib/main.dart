import 'package:bitcoin_ticker/src/provider/crypto_provider.dart';
import 'package:bitcoin_ticker/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  final CryptoProvider cryptoProvider = CryptoProvider();
  await cryptoProvider.init();
  runApp(
    ChangeNotifierProvider.value(
      value: cryptoProvider,
      child: const BitcoinTickerApp(),
    ),
  );
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
