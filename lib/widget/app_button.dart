import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double? buttonHeight;
  final double? buttonWidth;
  final Color backgroundColor;
  final void Function()? onTap;
  final String title;
  final TextStyle? titleStyle;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final double borderRaius;
  final Color? shadowColor;
  final EdgeInsets? contentPadding;
  const AppButton(
      {super.key,
      this.contentPadding,
      this.buttonHeight,
      required this.backgroundColor,
      this.onTap,
      required this.title,
      this.titleStyle,
      this.prefixWidget,
      this.suffixWidget,
      this.borderRaius = 12,
      this.buttonWidth,
      this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shadowColor: shadowColor,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRaius))),
      onPressed: onTap,
      child: Container(
        padding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: buttonHeight,
        alignment: Alignment.center,
        child: FittedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixWidget != null) prefixWidget!,
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: titleStyle ??
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
              ),
              if (suffixWidget != null) suffixWidget!,
            ],
          ),
        ),
      ),
    );
  }
}
