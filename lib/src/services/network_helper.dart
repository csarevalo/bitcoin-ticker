import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String _apiKey = '466291F6-86AD-4ADE-8DAD-39B743022341';
const String _sampleResponse =
    'https://raw.githubusercontent.com/csarevalo/bitcoin_ticker/refs/heads/main/lib/src/constants/sample_coinapi_response.json';

class NetworkHelper {
  final String baseURL;
  final String version;
  final String request;

  NetworkHelper({
    required this.baseURL,
    required this.version,
    required this.request,
  });

  /// Get the current exchange rate between requested asset and all other assets.
  Future<dynamic> getAllCurrentRates(
    /// Requested exchange rates base asset identifier
    String assetIdBase,
  ) async {
    String url = '$baseURL/$version/$request/$assetIdBase?apiKey=$_apiKey';
    // String url = _sampleResponse;
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      debugPrint(response.statusCode.toString());
    }
    return null;
  }

  /// Retrieves the exchange rate for a specific base and quote asset at a given time or the current rate.
  Future<dynamic> getSpecificCurrentRate(
    /// Requested exchange rates base asset identifier
    String assetIdBase,

    /// Requested exchange rate quote asset identifier
    String assetIdQuote,
  ) async {
    String url =
        '$baseURL/$version/$request/$assetIdBase/$assetIdQuote?apiKey=$_apiKey';

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      debugPrint(response.statusCode.toString());
    }
    return null;
  }
}
