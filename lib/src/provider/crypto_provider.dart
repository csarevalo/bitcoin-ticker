import 'package:bitcoin_ticker/src/services/network_helper.dart';
import 'package:bitcoin_ticker/src/utils/coin_data.dart';
import 'package:flutter/material.dart';

class CryptoProvider extends ChangeNotifier {
  final NetworkHelper _networkHelper = NetworkHelper(
    baseURL: 'https://rest.coinapi.io/',
    version: 'v1',
    request: 'exchangerate',
  );

  Future<void> init() async {}

  /// Get Bitcoin exchange rate
  Future<CoinData> getCryptoRate({
    /// Requested exchange rate base asset identifier
    required String cryptoTicker,

    /// Requested exchange rate quote asset identifier
    required String quote,
  }) async {
    double rate = await _networkHelper.getSpecificCurrentRate(
      assetIdBase: cryptoTicker,
      assetIdQuote: quote,
    );
    return CoinData(
      name: 'Bitcoin',
      symbol: cryptoTicker,
      rate: rate,
    );
  }
}
