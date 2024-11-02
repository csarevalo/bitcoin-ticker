import 'package:bitcoin_ticker/src/services/network_helper.dart';
import 'package:bitcoin_ticker/src/utils/coin_data.dart';
import 'package:flutter/material.dart';

class CryptoProvider extends ChangeNotifier {
  final NetworkHelper _networkHelper = NetworkHelper(
    baseURL: 'https://rest.coinapi.io/',
    version: 'v1',
    request: 'exchangerate',
  );

  late List<dynamic> _allCryptoData;

  /// Private selected currency
  late String _selectedCurrency;

  /// Get selected currency from provider
  String get selectedCurrency => _selectedCurrency;

  /// Select a new currency
  void selectNewCurrency(String newCurrency) {
    _selectedCurrency = newCurrency;
    notifyListeners();
  }

  Future<void> init() async {
    _selectedCurrency = 'USD';
    _allCryptoData = [];
    dynamic data;
    for (String cryptoTicker in cryptoList) {
      // Get current rate from network helper (coin api)
      data = await _networkHelper.getAllCurrentRates(cryptoTicker);
      _allCryptoData.add(data);
    }
  }

  /// Get Bitcoin exchange rate
  Future<CoinData> getCryptoRate({
    /// Requested exchange rate base asset identifier
    required String cryptoTicker,

    /// Requested exchange rate quote asset identifier
    required String quote,
  }) async {
    dynamic data;
    double rate;
    int index;

    // Get data from [_allCryptoData] stored in app
    if (_allCryptoData.isNotEmpty) {
      // Get index of relevant crypto data
      index = _allCryptoData.indexWhere(
        (cryptoData) => cryptoData['asset_id_base'] == cryptoTicker,
      );
      // Check if valid index, and get relevant crypto data
      data = index != -1 ? _allCryptoData[index] : null;
    } else {
      // Get current rate from network helper (coin apis)
      data = await _networkHelper.getAllCurrentRates(cryptoTicker);
    }
    // Verify crypto data
    if (data == null) return _coinDataError('Trouble getting crypto data');
    // Get index of [quote] inside response
    index = data['rates'].indexWhere((quoteResponse) {
      String assetIdQuote = quoteResponse['asset_id_quote'].toString();
      return assetIdQuote == quote.toUpperCase();
    });
    // Check if valid index (found currency exchange)
    if (index != -1) {
      // Get crypto rate exchange
      rate = data['rates'][index]['rate'];
      return CoinData(
        symbol: cryptoTicker,
        rate: rate,
      );
    } else {
      return _coinDataError('Trouble getting crypto rate exchange');
    }
  }
}

CoinData _coinDataError(String msg) {
  return CoinData(symbol: msg, rate: 0);
}
