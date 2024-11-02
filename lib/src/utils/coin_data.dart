const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BNB',
  'BTC',
  'ETH',
  'LTC',
  'SOL',
  'USDT',
];

class CoinData {
  final String symbol;
  final double rate;

  CoinData({
    required this.symbol,
    required this.rate,
  });
}
