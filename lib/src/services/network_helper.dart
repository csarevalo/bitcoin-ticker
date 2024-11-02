import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String _apiKey = '466291F6-86AD-4ADE-8DAD-39B743022341';
const String _sampleBaseUrl =
    'https://raw.githubusercontent.com/csarevalo/bitcoin-ticker/refs/heads/main/lib/src/constants/';

class NetworkHelper {
  final String baseURL;
  final String version;
  final String request;

  NetworkHelper({
    required this.baseURL,
    this.version = '',
    required this.request,
  });

  /// Get the current exchange rate between requested asset and all other assets.
  Future<dynamic> getAllCurrentRates(
    /// Requested exchange rates base asset identifier
    String assetIdBase,
  ) async {
    // Get CoinApi URL
    String url = _getUrl(newRequest: true, assetIdBase: assetIdBase);
    // Request CoinApi all current crypto exchange rates
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Good CoinApi response
      return jsonDecode(response.body);
    } else {
      // Bad CoinApi response
      debugPrint('[CoinApi] Status: ${response.statusCode.toString()}');
      debugPrint('[CoinApi] URL: $url');
      // Get GitHub sample crypto url
      url = _getUrl(newRequest: false, assetIdBase: assetIdBase);
      // Request sample crypto data from repo
      response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Good GitHub Response
        return jsonDecode(response.body);
      } else {
        // Bad GitHub Response
        debugPrint('[GitHub] Status: ${response.statusCode.toString()}');
        debugPrint('[GitHub] URL: $url');
      }
    }
    return null;
  }

  /// Retrieves the exchange rate for a specific base and quote asset at a given time or the current rate.
  Future<dynamic> getSpecificCurrentRate({
    /// Requested exchange rates base asset identifier
    required String assetIdBase,

    /// Requested exchange rate quote asset identifier
    required String assetIdQuote,
  }) async {
    // Get CoinApi url
    String url = _getUrl(
      newRequest: true,
      assetIdBase: assetIdBase,
      assetIdQuote: assetIdBase,
    );
    // Request CoinApi specific and current crypto rate
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Good CoinApi response
      return jsonDecode(response.body);
    } else {
      // Bad response
      debugPrint(response.statusCode.toString());
    }
    return null;
  }

  String _getUrl({
    bool newRequest = false,
    required String assetIdBase,
    String assetIdQuote = '',
  }) {
    if (newRequest) {
      // Add version if not empty
      String ver = version.isEmpty ? '' : '$version/';
      // Add desired currency quote if not empty
      String quote = assetIdQuote.isEmpty ? '' : '/$assetIdQuote';
      return '$baseURL$ver$request/$assetIdBase$quote?apiKey=$_apiKey';
    }
    return '$_sampleBaseUrl${assetIdBase.toLowerCase()}_sample_coinapi_response.json';
  }
}
