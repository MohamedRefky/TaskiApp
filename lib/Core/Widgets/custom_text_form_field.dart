import 'package:flutter/material.dart';

class CustomTextFormfield extends StatelessWidget {
  const CustomTextFormfield({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.hintStyle,
    this.maxLines,
    this.validator,
  });
  final TextEditingController controller;
  final String title;
  final int? maxLines;
  final String hintText;
  final TextStyle? hintStyle;
  final Function(String)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator != null
              ? (String? value) => validator!(value!)
              : null,
          maxLines: maxLines,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(hintStyle: hintStyle, hintText: hintText),
        ),
      ],
    );
  }
}
