import 'package:bitcoin_ticker/src/provider/crypto_provider.dart';
import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.tickerSymbol,
    required this.currency,
    required this.cryptoProvider,
  });
  final String tickerSymbol;
  final String currency;
  final CryptoProvider cryptoProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center, //vertical
        title: FutureBuilder(
          future: cryptoProvider.getCryptoRate(
            cryptoTicker: tickerSymbol,
            quote: currency,
          ),
          builder: (context, snapshot) {
            String coinRate = 'loading';
            if (snapshot.hasData) {
              coinRate = snapshot.data!.rate.toStringAsFixed(2);
              return Text(
                '1 ${tickerSymbol.toUpperCase()} = $coinRate ${currency.toUpperCase()}',
                textAlign: TextAlign.center,
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('1 ${tickerSymbol.toUpperCase()} =    '),
                const CircularProgressIndicator.adaptive(),
                Text('    $currency'),
              ],
            );
          },
        ),
      ),
    );
  }
}
