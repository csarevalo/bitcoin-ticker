import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier {
  String _currency = 'USD';
  String get currency => _currency;

  Future<void> init() async {}
}
