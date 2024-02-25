import 'package:flutter/material.dart';

import 'keyboard_dismiss.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  String title;
  Color? titleColor;
  Widget? leadingWidget;
  double? elevate;
  Color? color;
  List<Widget>? trailingWidgets;
  AppBarWidget(
      {Key? key,
      required this.title,
      this.leadingWidget,
      this.trailingWidgets,
      this.titleColor,
      this.elevate,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevate ?? 1,
      shadowColor: Colors.black38,
      color: color ?? Colors.white,
      child: WKeyboardDismiss(
        child: Container(
          height: 57,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: leadingWidget ?? Container(),
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: trailingWidgets ?? [],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
