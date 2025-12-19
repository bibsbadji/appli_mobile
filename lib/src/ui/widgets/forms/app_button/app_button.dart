import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.borderRaduis = 12.0,
    this.bgColor,
    this.textColor,
    this.icon,
    this.width,
    this.height = 50,
    this.fontZise = 16,
  });

  final VoidCallback onPressed;
  final String text;
  final double borderRaduis;
  final Color? bgColor;
  final Color? textColor;
  final Widget? icon;
  final double? width;
  final double height;
  final double fontZise;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRaduis)
          ),
        ), 
        child: icon != null
            ? Row(mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              icon!,
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color:
                    textColor ??
                    Theme.of(context).colorScheme.onPrimary,
                    fontSize: fontZise,
                ),
              )
            ],
             )
             : Text(text,
             style: TextStyle(
              color: textColor ?? Theme.of(context).colorScheme.onPrimary,
              fontSize: fontZise,
             ),
             )
        ),
    );
  }
}
