import 'package:flutter/material.dart';
import 'package:money_converter/core/constant/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.number,
      textAlign: TextAlign.end,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: .w500,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputBg,
        contentPadding: const .symmetric(vertical: 16, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: .none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: .none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: .none,
        ),

        hintText: hintText ?? '000.00',
        hintStyle: TextStyle(
          fontSize: 20,
          color: AppColors.black.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
