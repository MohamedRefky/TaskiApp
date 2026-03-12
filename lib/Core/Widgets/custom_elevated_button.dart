import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.text, this.icon});
  final Widget text;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: text,
      icon: Icon(Icons.add),
      onPressed: () {},
    );
  }
}
