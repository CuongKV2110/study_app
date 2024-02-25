import 'package:flutter/material.dart';

/// Widget deal with tab on screen to close keyboard
class WKeyboardDismiss extends StatelessWidget {
  const WKeyboardDismiss({
    required this.child,
    this.unFocus,
    Key? key,
  }) : super(key: key);

  final Widget? child;
  final Function()? unFocus;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}
