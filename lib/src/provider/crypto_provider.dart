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
    dynamic data;
    double rate;

    // Try getting crypto data from coin api
    data = null;
    // data = await _networkHelper.getSpecificCurrentRate(
    //   assetIdBase: cryptoTicker,
    //   assetIdQuote: quote,
    // );
    // debugPrint(data['rates'].toString());
    if (data == null) {
      // If no data (because of error or other), use default GitHub data
      data = await _networkHelper.getAllCurrentRates(cryptoTicker);
      int index = data['rates'].indexWhere((quoteResponse) {
        String assetIdQuote = quoteResponse['asset_id_quote'].toString();
        return assetIdQuote == quote.toUpperCase();
      });
      rate = data['rates'][index]['rate'];
    } else {
      rate = data['rate'];
    }
    return CoinData(
      name: 'Bitcoin',
      symbol: cryptoTicker,
      rate: rate,
    );
  }

  CoinData coinDataError(String msg) {
    return CoinData(
      name: 'Error',
      symbol: 'Trouble getting ticker rate',
      rate: 0,
    );
  }
}
