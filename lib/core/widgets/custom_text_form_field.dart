import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode autovalidateMode;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.validator,
    this.onSaved,
    this.keyboardType,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.inputFormatters,
  });
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      cursorHeight: 18,
      autovalidateMode: autovalidateMode,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      validator: validator,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.primaryColor,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.primaryColor,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.primaryColor,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        prefixIcon: suffixIcon,
      ),
    );
  }
}
