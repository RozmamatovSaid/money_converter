import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_converter/core/constant/api_constants.dart';
import 'package:money_converter/core/constant/app_colors.dart';
import 'package:money_converter/core/constant/app_constants.dart';
import 'package:money_converter/core/data/extensions/sizedbox_extension.dart';
import 'package:money_converter/core/widget/app_inkwell.dart';
import 'package:money_converter/core/widget/app_text.dart';
import 'package:money_converter/features/main/domain/entity/currency_entity.dart';

class CurrencySelectBottomsheet extends StatelessWidget {
  const CurrencySelectBottomsheet({
    super.key,
    required this.fromCurrency,
    required this.currencies,
    required this.onSelect,
  });

  final String fromCurrency;
  final List<CurrencyEntity> currencies;
  final Function(CurrencyEntity) onSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: currencies.length,
          separatorBuilder: (context, index) => 5.height,
          itemBuilder: (context, index) {
            final items = currencies[index];
            return Column(
              children: [
                AppInkWell(
                  onTap: () {
                    onSelect(currencies[index]);
                    context.pop();
                  },
                  child: Row(
                    spacing: 20,
                    children: [
                      ClipRRect(
                        borderRadius: .circular(100),
                        child: CachedNetworkImage(
                          fit: .cover,
                          width: 50,
                          height: 50,
                          imageUrl:
                              '${ApiConstants.networkFlag}${AppConstants.ccyToCountryCode[items.ccy]}.png',
                        ),
                      ),
                      AppText(
                        items.ccyNmUz,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
