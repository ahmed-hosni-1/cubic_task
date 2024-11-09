import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text_form_field.dart';

class CustomAuthField extends StatelessWidget {
  final String title;
  final String? Function(String?) validator;
  final String hintText;
  final Widget suffixIcon;
  AutovalidateMode autovalidateMode;

   CustomAuthField({
    super.key,
    required this.title,
    required this.validator,
    required this.hintText,
    required this.suffixIcon,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FadeInLeft(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        CustomTextFormField(
          autovalidateMode:autovalidateMode ,
          validator: validator,
          hintText: hintText,
          suffixIcon: suffixIcon,
        ),
      ]),
    );
  }
}
