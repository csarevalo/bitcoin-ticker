import 'package:bitcoin_ticker/src/provider/crypto_provider.dart';
import 'package:bitcoin_ticker/src/utils/coin_data.dart';
import 'package:bitcoin_ticker/src/widgets/picker_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyPicker extends StatefulWidget {
  const CurrencyPicker({
    super.key,
  });

  @override
  State<CurrencyPicker> createState() => _CurrencyPickerState();
}

class _CurrencyPickerState extends State<CurrencyPicker> {
  late String selectedCurrencyOnPicker;
  late String initialCurrency;
  late final CryptoProvider cryptoProvider;

  @override
  void initState() {
    super.initState();
    cryptoProvider = Provider.of<CryptoProvider>(context, listen: false);
    selectedCurrencyOnPicker = cryptoProvider.selectedCurrency;
    initialCurrency = selectedCurrencyOnPicker;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CurrencyPickerHeader(
          onDone: () {
            debugPrint(selectedCurrencyOnPicker);
            cryptoProvider.selectNewCurrency(selectedCurrencyOnPicker);
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 150,
          child: Center(
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: currenciesList.indexOf(initialCurrency),
              ),
              itemExtent: 32,
              onSelectedItemChanged: (itemIndex) {
                selectedCurrencyOnPicker = currenciesList[itemIndex];
              },
              children: currenciesList.map<Text>((s) => Text(s)).toList(),
            ),
          ),
        )
      ],
    );
  }
}

class CurrencyPickerHeader extends StatelessWidget {
  const CurrencyPickerHeader({
    super.key,
    this.textColor,
    required this.onDone,
  });

  final Color? textColor;

  final void Function() onDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PickerActionButton(
          onPressed: () => Navigator.pop(context),
          title: 'Cancel',
          textColor: textColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
          ),
        ),
        Expanded(
          child: Text(
            'Select Currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  textColor ?? Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        PickerActionButton(
          onPressed: onDone,
          title: 'Done',
          textColor: textColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(28),
          ),
        ),
      ],
    );
  }
}
