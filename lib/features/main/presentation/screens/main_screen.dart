import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_converter/core/constant/api_constants.dart';
import 'package:money_converter/core/constant/app_colors.dart';
import 'package:money_converter/core/constant/app_constants.dart';
import 'package:money_converter/core/constant/app_strings.dart';
import 'package:money_converter/core/data/extensions/sizedbox_extension.dart';
import 'package:money_converter/core/widget/app_container.dart';
import 'package:money_converter/core/widget/app_inkwell.dart';
import 'package:money_converter/core/widget/app_text.dart';
import 'package:money_converter/features/main/domain/entity/currency_entity.dart';
import 'package:money_converter/features/main/presentation/cubit/currency_cubit.dart';
import 'package:money_converter/features/main/presentation/state/main_screen_state.dart';
import 'package:money_converter/features/main/presentation/widgets/currency_input_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends MainScreenState {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  50.height,
                  AppText(
                    AppStrings.currencyConverter.tr(context: context),
                    textAlign: .center,
                    fontWeight: .w700,
                    fontSize: 25,
                    color: AppColors.textColor,
                  ),
                  10.height,
                  AppText(
                    AppStrings.subtitle.tr(context: context),
                    fontSize: 16,
                    color: AppColors.grey,
                    textAlign: TextAlign.center,
                  ),
                  40.height,
                  BlocBuilder<CurrencyCubit, CurrencyState>(
                    builder: (context, state) {
                      if (state.currencies.length < 2) {
                        return const SizedBox.shrink();
                      }

                      final CurrencyEntity selectFromtCurrency =
                          state.selectedFromCurrency ?? state.currencies.first;
                      final CurrencyEntity selectToCurrency =
                          state.selectedToCurrency ?? state.currencies[1];

                      final fromAmount = CurrencyInputCard(
                        title: state.isSwap
                            ? AppStrings.amount.tr(context: context)
                            : AppStrings.convertedAmount.tr(context: context),
                        flag:
                            '${ApiConstants.networkFlag}${AppConstants.ccyToCountryCode[selectFromtCurrency.ccy]}.png',
                        ccy: selectFromtCurrency.ccy,
                        controller: fromAmountController,
                        onChanged: (value) => onFromAmountChanged(
                          value,
                          selectFromtCurrency,
                          selectToCurrency,
                        ),
                        onCurrencyTap: () => onFromCurrencyTap(
                          context,
                          state.currencies,
                          selectFromtCurrency,
                        ),
                      );
                      final toAmount = CurrencyInputCard(
                        title: state.isSwap
                            ? AppStrings.convertedAmount.tr(context: context)
                            : AppStrings.amount.tr(context: context),
                        flag:
                            '${ApiConstants.networkFlag}${AppConstants.ccyToCountryCode[selectToCurrency.ccy]}.png',
                        ccy: selectToCurrency.ccy,
                        controller: toAmountController,
                        onChanged: (value) => onToAmountChanged(
                          value,
                          selectFromtCurrency,
                          selectToCurrency,
                        ),
                        onCurrencyTap: () => onToCurrencyTap(
                          context,
                          state.currencies,
                          selectToCurrency,
                        ),
                      );

                      return AppContainer(
                        width: .infinity,
                        padding: .all(20),
                        radius: .circular(20),
                        child: Column(
                          spacing: 14,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            state.isSwap ? fromAmount : toAmount,
                            SizedBox(
                              height: 80,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const Divider(color: AppColors.inputBorder),
                                  AppInkWell(
                                    borderRadius: .circular(100),
                                    onTap: () {
                                      context
                                          .read<CurrencyCubit>()
                                          .swapConverterField();
                                    },
                                    child: AppContainer(
                                      padding: EdgeInsets.all(15),
                                      shape: BoxShape.circle,
                                      color: AppColors.primary,
                                      child: Icon(
                                        Icons.swap_vert,
                                        size: 30,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            state.isSwap ? toAmount : fromAmount,
                          ],
                        ),
                      );
                    },
                  ),
                  24.height,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      AppStrings.indicativeExchangeRate.tr(context: context),
                      color: AppColors.grey,
                      fontSize: 16,
                    ),
                  ),
                  10.height,
                  BlocBuilder<CurrencyCubit, CurrencyState>(
                    builder: (context, state) {
                      if (state.currencies.length < 2) {
                        return const SizedBox.shrink();
                      }

                      final CurrencyEntity selectFromtCurrency =
                          state.selectedFromCurrency ?? state.currencies.first;
                      final CurrencyEntity selectToCurrency =
                          state.selectedToCurrency ?? state.currencies[1];
                      final CurrencyEntity rateFromCurrency = state.isSwap
                          ? selectFromtCurrency
                          : selectToCurrency;
                      final CurrencyEntity rateToCurrency = state.isSwap
                          ? selectToCurrency
                          : selectFromtCurrency;

                      return Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          '${rateFromCurrency.nominal} ${rateFromCurrency.ccy} = ${formatExchangeRate(rateFromCurrency, rateToCurrency)} ${rateToCurrency.ccy}',
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
