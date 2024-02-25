import 'package:flutter/services.dart';

class AvoidStartWithSpaceFormatter extends TextInputFormatter {
  AvoidStartWithSpaceFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int oldTextLength = oldValue.text.length;
    return newValue.text.trim().isEmpty && oldTextLength == 0
        ? oldValue
        : newValue;
  }
}
