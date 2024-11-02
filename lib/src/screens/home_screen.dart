import 'package:bitcoin_ticker/src/provider/crypto_provider.dart';
import 'package:bitcoin_ticker/src/utils/coin_data.dart';
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
            const SizedBox(height: 8.0),
            Selector<CryptoProvider, String>(
              selector: (_, p) => p.selectedCurrency,
              builder: (_, String currency, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: cryptoList
                      .map<Widget>(
                        (cryptoTicker) => CryptoCard(
                          tickerSymbol: cryptoTicker,
                          currency: currency,
                          cryptoProvider: cryptoProvider,
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
