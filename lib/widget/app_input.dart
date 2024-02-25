import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';

import '../utils/avoid_start_with_space_fomatter.dart';

class AppInput extends StatefulWidget {
  const AppInput(
      {super.key,
      this.autoValidateMode,
      this.borderRadius,
      this.controller,
      this.enabled = true,
      this.fillColor,
      this.floatingLabelBehavior = FloatingLabelBehavior.auto,
      this.focusNode,
      this.hintStyle,
      this.hintText,
      this.labelText,
      this.onSaved,
      this.validator,
      this.trailingIcon,
      this.leadingIcon,
      this.textStyle,
      this.lableStyle,
      this.errorText,
      this.onchange,
      this.onTapWidget,
      this.keyboardType = TextInputType.text,
      this.maxLines,
      this.minLines,
      this.obscureText = false,
      this.maxLength,
      this.textInputFormatters,
      this.title,
      this.isRequired = false,
      this.usingEyeIcon = false,
      this.autoTrim = false,
      this.readOnly,
      this.textInputAction,
      this.onFieldSubmitted,
      this.toolbarOptions,
      this.onChangeFocus,
      this.contentPadding,
      this.border});

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final Widget? trailingIcon;
  final Widget? leadingIcon;
  final double? borderRadius;
  final Color? fillColor;
  final TextInputType keyboardType;
  final FloatingLabelBehavior floatingLabelBehavior;
  final AutovalidateMode? autoValidateMode;
  final bool obscureText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? lableStyle;
  final void Function(String?)? onchange;
  final void Function()? onTapWidget;
  final List<TextInputFormatter>? textInputFormatters;
  final String? title;
  final bool isRequired;
  final bool usingEyeIcon;
  final bool autoTrim;
  final String? errorText;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final void Function(String?)? onFieldSubmitted;
  final ToolbarOptions? toolbarOptions;
  final Function(bool hasFocus)? onChangeFocus;
  final EdgeInsets? contentPadding;
  final OutlineInputBorder? border;

  @override
  State<StatefulWidget> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool showObscureText = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    showObscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() => setState(() {
          widget.onChangeFocus?.call(_focusNode.hasFocus);
          if (widget.autoTrim) {
            widget.controller?.text = widget.controller?.text.trim() ?? '';
          }
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.title != null) ...[
          Text.rich(
            TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                  child: Text(
                    widget.title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                if (widget.isRequired)
                  const WidgetSpan(
                    child: Text(
                      ' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          )
        ],
        GestureDetector(
          onTap: widget.onTapWidget,
          child: TextFormField(
            readOnly: widget.readOnly ?? false,
            textAlignVertical: TextAlignVertical.center,
            autovalidateMode: widget.autoValidateMode,
            controller: widget.controller,
            maxLength: widget.maxLength,
            minLines: widget.minLines,
            maxLines: widget.maxLines ?? 1,
            keyboardType: widget.keyboardType,
            focusNode: _focusNode,
            inputFormatters: [
              if (widget.autoTrim) AvoidStartWithSpaceFormatter(),
              ...(widget.textInputFormatters ?? [])
            ],
            textInputAction: widget.textInputAction,
            enabled: widget.enabled,
            obscureText: showObscureText,
            validator: widget.validator,
            style: widget.textStyle,
            onChanged: widget.onchange,
            cursorWidth: 2,
            cursorColor: Colors.black,
            onSaved: widget.onSaved,
            onFieldSubmitted: widget.onFieldSubmitted,
            decoration: InputDecoration(
              errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
              contentPadding: widget.contentPadding ??
                  EdgeInsets.only(
                      left: widget.leadingIcon != null ? 0 : 20,
                      right: hasTrailingWidget() ? 0 : 20),
              border: widget.border ??
                  OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 25)),
              errorBorder: widget.border ??
                  OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 25)),
              focusedBorder: widget.border ??
                  OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 25)),
              disabledBorder: widget.border ??
                  OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 25)),
              focusedErrorBorder: widget.border ??
                  OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 25)),
              enabledBorder: widget.border ??
                  OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 25)),
              labelStyle: widget.lableStyle,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              enabled: widget.enabled,
              filled: true,
              // isDense: true,
              fillColor: widget.fillColor ?? Colors.white,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              errorText: widget.errorText,
              prefixIcon: widget.leadingIcon,
              errorMaxLines: 3,
              suffixIcon: widget.trailingIcon ??
                  (widget.usingEyeIcon &&
                          widget.obscureText &&
                          _focusNode.hasFocus
                      ? GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(showObscureText
                                ? Ionicons.eye_off_outline
                                : Ionicons.eye_outline),
                          ),
                          onTap: () => setState(() {
                            showObscureText = !showObscureText;
                          }),
                        )
                      : null),
            ),
          ),
        ),
      ],
    );
  }

  bool hasTrailingWidget() {
    return widget.usingEyeIcon && widget.obscureText && _focusNode.hasFocus ||
        widget.trailingIcon != null;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
