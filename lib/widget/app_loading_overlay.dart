import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'app_loading_widget.dart';

class AppLoadingOverlay extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final Color? color;
  final Widget? progressIndicator;

  const AppLoadingOverlay(
      {super.key,
      required this.child,
      required this.isLoading,
      this.color,
      this.progressIndicator});

  @override
  State<AppLoadingOverlay> createState() => _AppLoadingOverlayState();
}

class _AppLoadingOverlayState extends State<AppLoadingOverlay> {
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: widget.isLoading,
      color: widget.color ?? Colors.grey.withOpacity(0.8),
      child: widget.child,
      progressIndicator: widget.progressIndicator ?? const AppLoadingWidget(),
    );
  }
}
