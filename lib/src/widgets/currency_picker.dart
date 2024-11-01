import 'package:bitcoin_ticker/src/utils/coin_data.dart';
import 'package:bitcoin_ticker/src/widgets/picker_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyPicker extends StatelessWidget {
  final String initialCurrency;

  const CurrencyPicker({
    super.key,
    this.initialCurrency = 'USD',
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onPrimaryContainer;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,

      children: [
        CurrencyPickerHeader(textColor: textColor),
        SizedBox(
          height: 150,
          child: Center(
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: currenciesList.indexOf(initialCurrency),
              ),
              itemExtent: 32,
              onSelectedItemChanged: (itemIndex) {
                debugPrint(currenciesList[itemIndex]);
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
  });

  final Color? textColor;

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
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        PickerActionButton(
          onPressed: () => Navigator.pop(context),
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
