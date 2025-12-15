import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput({
    Key? key,
    this.controller,
    required this.labelText,
    this.iconData,
    this.prefixIcon,
    this.suffixIcon,
    this.ispassword = false,
    this.enabled,
    this.obscureText,
    this.text,
    this.validator,
    String? errorText,
    this.initialValue,
    this.decoration, required BorderRadius borderRadius,
  }) : super(key: key);

  final TextEditingController? controller;
  final String labelText;
  final IconData? iconData;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool ispassword;
  final bool? enabled;
  final bool? obscureText;
  final String? text;
  String? Function(String?)? validator;
  final String? initialValue;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          icon: iconData != null ? Icon(iconData) : null,
        ),
        obscureText: ispassword,
        enabled: enabled,
        initialValue: text,
        validator: validator,
      ),
    );
  }
}
