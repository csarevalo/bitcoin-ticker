import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String _apiKey = '466291F6-86AD-4ADE-8DAD-39B743022341';
const String _sampleBaseUrl =
    'https://raw.githubusercontent.com/csarevalo/bitcoin_ticker/refs/heads/main/lib/src/constants/';

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
    String url = _getUrl(newRequest: false, assetIdBase: assetIdBase);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      debugPrint(response.statusCode.toString());
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
    String url = _getUrl(newRequest: false, assetIdBase: assetIdBase);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
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
      String ver = version.isEmpty ? '' : '$version/';
      String quote = assetIdQuote.isEmpty ? '' : '/$assetIdQuote';
      return '$baseURL/$ver$request/$assetIdBase$quote?apiKey=$_apiKey';
    }
    return '$_sampleBaseUrl${assetIdBase.toLowerCase()}_sample_coinapi_response.json';
  }
}
