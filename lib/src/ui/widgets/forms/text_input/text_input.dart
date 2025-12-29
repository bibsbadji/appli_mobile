import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  TextInput({
    Key? key,
    this.controller,
    required this.labelText,
    this.iconData,
    this.prefixIcon,
    this.suffixIcon,
    this.ispassword = false,
    this.enabled,
    this.text,
    this.validator,
    this.errorText,
    this.initialValue,
    this.borderRadius,
    this.borderColor, // nouvelle propriété
  }) : super(key: key);

  final TextEditingController? controller;
  final String labelText;
  final IconData? iconData;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool ispassword;
  final bool? enabled;
  final String? text;
  final String? Function(String?)? validator;
  final String? errorText;
  final String? initialValue;
  final BorderRadius? borderRadius;
  final Color? borderColor; // couleur personnalisée

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.ispassword;
  }

  @override
  Widget build(BuildContext context) {
    final Color borderClr = widget.borderColor ?? Theme.of(context).primaryColor;

    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: widget.controller,
        enabled: widget.enabled,
        initialValue: widget.initialValue ?? widget.text,
        obscureText: _obscureText,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.labelText,
          errorText: widget.errorText,

          prefixIcon: widget.prefixIcon ?? (widget.iconData != null ? Icon(widget.iconData) : null),


          suffixIcon: widget.ispassword
              ? IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : widget.suffixIcon,


          border: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            borderSide: BorderSide(color: borderClr, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            borderSide: BorderSide(color: borderClr, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),

          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        ),
      ),
    );
  }
}
