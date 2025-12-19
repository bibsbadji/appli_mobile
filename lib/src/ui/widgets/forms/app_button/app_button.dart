import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.borderRaduis = 12,
    this.bgColor,
    this.textColor,
    this.icon,
    this.width,
    this.height = 50,
    this.fontSize = 16,
    this.isOutline = false,
    this.borderColor,
  });

  final VoidCallback onPressed;
  final String text;
  final double borderRaduis;
  final Color? bgColor;
  final Color? textColor;
  final Widget? icon;
  final double? width;
  final double height;
  final double fontSize;
  final bool isOutline;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final Color finalBgColor =
    isOutline ? Colors.white : (bgColor ?? Colors.red);

    final Color finalTextColor =
        textColor ?? (isOutline ? Colors.red : Colors.white);

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: isOutline ? 0 : 2,
          backgroundColor: finalBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRaduis),
            side: isOutline
                ? BorderSide(color: borderColor ?? Colors.red)
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: finalTextColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
