import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../res/color_manager.dart';

class DefaultTextField extends StatefulWidget {
  final String? title;
  final bool secure;
  final String name;
  final TextInputType inputType;
  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  final String? label;
  final Function(String?)? onSubmitted;
  final Color? fillColor;
  final Widget? prefixIcon;
  final bool readOnly;
  final bool filled;
  final int? maxLength;
  final TextAlign? textAlign;
  final num height;
  final num width;
  final GestureTapCallback? onTap;
  final String? suffixText;
  final TextInputAction action;
  final bool autoFocus;
  final FocusNode? focusNode;
  final Widget? prefixWidget;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? suffixWidget;
  final VoidCallback? onPressSuffixIcon;
  final bool? isPassword;
  final int? maxLines;
  final bool? hasBorderColor;
  final Color? borderColor;
  final void Function(String?)? onChanged;
  final bool closeWhenTapOutSide;
  final TextStyle? style;

  const DefaultTextField({
    super.key,
    this.title,
    this.secure = false,
    this.inputType = TextInputType.text,
    this.borderColor,
    this.onTap,
    this.controller,
    this.closeWhenTapOutSide = true,
    this.hasBorderColor = true,
    this.validator,
    required this.name,
    this.label,
    this.onSubmitted,
    this.suffixWidget,
    this.isPassword = false,
    this.fillColor,
    this.inputFormatters,
    this.prefixIcon,
    this.prefixWidget,
    this.maxLength,
    this.filled = true,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.height = 10,
    this.width = 10,
    this.action = TextInputAction.next,
    this.focusNode,
    this.autoFocus = false,
    this.suffixText,
    this.suffixIcon,
    this.onPressSuffixIcon,
    this.maxLines,
    this.onChanged,
    this.style,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  late bool _isSecure;

  @override
  void initState() {
    if (widget.isPassword != null) {
      _isSecure = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLabel = widget.label != null;
    return FormBuilderTextField(
      controller: widget.controller,
      name: widget.name,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.isPassword == true ? _isSecure : widget.secure,
      onTap: widget.onTap,
      onTapOutside: (event) {
        if (widget.closeWhenTapOutSide == true) {
          FocusScope.of(context).unfocus();
        }
      },
      keyboardType: widget.inputType,
      autofillHints: _getAutoFillHints(widget.inputType),
      validator: widget.validator,
      maxLength: widget.maxLength,
      readOnly: widget.onTap != null ? true : widget.readOnly,
      textAlign: widget.textAlign!,
      maxLines: widget.inputType == TextInputType.multiline
          ? widget.maxLines ?? 7
          : 1,
      style: widget.style,
      onSubmitted: widget.onSubmitted,
      textInputAction: widget.action,
      enableSuggestions: false,
      autocorrect: false,
      autofocus: widget.autoFocus,
      focusNode: widget.autoFocus == true ? widget.focusNode : null,
      cursorColor: ColorManager.primary,
      decoration: InputDecoration(
        isDense: true,
        counterText: '',
        filled: widget.filled,
        suffixText: widget.suffixText,
        prefixIcon: widget.isPassword == true
            ? Icon(Icons.lock_outline, color: ColorManager.greyHintText)
            : widget.prefixIcon,
        suffixIcon: widget.isPassword == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isSecure = !_isSecure;
                  });
                },
                icon: Icon(
                  _isSecure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: ColorManager.greyHintText,
                ),
              )
            : widget.suffixIcon,
        prefix: widget.prefixWidget,
        fillColor: widget.fillColor ?? Colors.white,
        hintText: widget.title,
        label: isLabel ? Text(widget.label!) : null,
        labelStyle: isLabel ? TextStyle(color: ColorManager.greyLightText) : null,
        hintStyle: TextStyle(
            color: ColorManager.greyHintText, fontWeight: FontWeight.w300),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: widget.hasBorderColor == true
              ? BorderSide(color: widget.borderColor ?? ColorManager.dark1)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorManager.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorManager.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorManager.red),
        ),
      ),
    );
  }
}

List<String> _getAutoFillHints(TextInputType inputType) {
  if (inputType == TextInputType.emailAddress) {
    return [AutofillHints.email];
  } else if (inputType == TextInputType.datetime) {
    return [AutofillHints.birthday];
  } else if (inputType == TextInputType.phone) {
    return [AutofillHints.telephoneNumber];
  } else if (inputType == TextInputType.url) {
    return [AutofillHints.url];
  }
  return [AutofillHints.name, AutofillHints.username];
}