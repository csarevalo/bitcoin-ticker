import 'package:bitcoin_ticker/src/widgets/currency_picker.dart';
import 'package:flutter/material.dart';

class SelectCurrencyButton extends StatelessWidget {
  const SelectCurrencyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return const CurrencyPicker();
          },
        );
      },
      shape: const ContinuousRectangleBorder(),
      minWidth: double.maxFinite,
      height: kToolbarHeight * 0.85,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: const Text(
        'Select Currency!',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
