import 'package:bitcoin_ticker/src/widgets/crypto_card.dart';
import 'package:bitcoin_ticker/src/widgets/select_currency_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Title(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.currency_bitcoin_rounded),
                Text(
                  'i t c o i n  T i c k e r 🪙',
                ),
              ],
            ),
          ),
        ),
        body: const Column(
          children: [
            SelectCurrencyButton(),
            CryptoCard(
              tickerSymbol: 'BTC',
              currency: 'USD',
            ),
          ],
        ),
      ),
    );
  }
}
