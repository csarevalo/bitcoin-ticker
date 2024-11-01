import 'package:flutter/material.dart';

class PickerActionButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final BorderRadiusGeometry borderRadius;
  final Color? color;
  final Color? textColor;
  const PickerActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      color: color,
      textColor: textColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        child: Text(title),
      ),
    );
  }
}
