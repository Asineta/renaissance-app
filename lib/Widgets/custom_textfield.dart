import 'package:flutter/material.dart';
import 'package:renaissance/Utils/const.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  String? hint;
  Widget? suffix;
  Widget? prefix;
  TextInputAction? inputAction;
  var validator;
  var keyboardType;
  int maxline;
  bool? obscureText;
  var padding;
  var onTap;
  var readOnly;
  var initialValue;

  CustomTextField(
      {super.key,
      this.controller,
      this.hint,
      this.inputAction,
      this.suffix,
      this.prefix,
      this.validator,
      this.keyboardType,
      this.obscureText,
      this.maxline = 1,
      this.padding,
      this.onTap,
      this.initialValue,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxline,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      initialValue: initialValue,
      controller: controller,
      textInputAction: inputAction,
      cursorColor: iconFieldColor,
      textCapitalization: keyboardType != TextInputType.text
          ? TextCapitalization.none
          : TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: padding,
        hintText: hint,
        prefixIcon: prefix,
        suffixIcon: suffix,
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
