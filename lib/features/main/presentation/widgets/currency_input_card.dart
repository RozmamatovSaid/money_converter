import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:money_converter/core/constant/app_colors.dart';
import 'package:money_converter/core/widget/app_text.dart';
import 'package:money_converter/core/widget/app_textfield.dart';

class CurrencyInputCard extends StatelessWidget {
  const CurrencyInputCard({
    super.key,
    required this.title,
    required this.flag,
    required this.ccy,
    required this.onCurrencyTap,
    this.controller,
    this.onChanged,
  });

  final String title;
  final String flag;
  final String ccy;
  final VoidCallback onCurrencyTap;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 14,
      crossAxisAlignment: .start,
      children: [
        AppText(title, fontSize: 15, color: AppColors.textHint),
        Row(
          spacing: 16,
          children: [
            GestureDetector(
              onTap: onCurrencyTap,
              child: Row(
                spacing: 8,
                children: [
                  ClipRRect(
                    borderRadius: .circular(100),
                    child: CachedNetworkImage(
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                      imageUrl: flag,
                    ),
                  ),
                  AppText(
                    ccy,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textPrimary.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AppTextField(controller: controller, onChanged: onChanged),
            ),
          ],
        ),
      ],
    );
  }
}
