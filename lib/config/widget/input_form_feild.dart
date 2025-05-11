import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class InputFromFieldWidget extends StatelessWidget {
  final String hintText;
  final bool? isObscureText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChange;
  final Widget? suffixIcon;

  const InputFromFieldWidget(
      {super.key,
      required this.hintText,
      this.validator,
      required this.controller,
      required this.focusNode,
      required this.onChange,
      this.isObscureText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText ?? false,
      onChanged: onChange,
      focusNode: focusNode,
      controller: controller,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return 'Required Field';
            }
            return null;
          },
      decoration: InputDecoration(
        suffixIcon: suffixIcon ?? const SizedBox(),
        labelText: hintText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purple),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
      ),
    );
  }
}
