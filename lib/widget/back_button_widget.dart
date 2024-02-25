import 'package:flutter/material.dart';

import '../constants/constants.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, this.result});
  final dynamic result;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      child: backAppBarIcon,
      onTap: () => Navigator.pop(context, result),
    );
  }
}
