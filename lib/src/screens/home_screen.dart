import 'package:bitcoin_ticker/src/provider/crypto_provider.dart';
import 'package:bitcoin_ticker/src/widgets/crypto_card.dart';
import 'package:bitcoin_ticker/src/widgets/select_currency_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cryptoProvider = context.read<CryptoProvider>();
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
        body: Column(
          children: [
            const SelectCurrencyButton(),
            Selector<CryptoProvider, String>(
              selector: (_, p) => p.selectedCurrency,
              builder: (_, String currency, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CryptoCard(
                      tickerSymbol: 'BTC',
                      currency: currency,
                      cryptoProvider: cryptoProvider,
                    ),
                    // CryptoCard(
                    //   tickerSymbol: 'ETH',
                    //   currency: currency,
                    //   cryptoProvider: cryptoProvider,
                    // ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
