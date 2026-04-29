import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_converter/features/main/domain/entity/currency_entity.dart';
import 'package:money_converter/features/main/presentation/cubit/currency_cubit.dart';
import 'package:money_converter/features/main/presentation/screens/main_screen.dart';
import 'package:money_converter/features/main/presentation/widgets/currency_select_bottomsheet.dart';

abstract class MainScreenState extends State<MainScreen> {
  final TextEditingController fromAmountController = TextEditingController();
  final TextEditingController toAmountController = TextEditingController();

  final String fromCurrency = 'USD';
  final String toCurrency = 'UZS';

  @override
  void dispose() {
    fromAmountController.dispose();
    toAmountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<CurrencyCubit>().getCurrencies();
  }

  void onFromAmountChanged(
    String value,
    CurrencyEntity fromCurrencyItem,
    CurrencyEntity toCurrencyItem,
  ) {
    final amount = double.tryParse(value.replaceAll(',', '.')) ?? 0;

    toAmountController.text =
        (amount *
                (fromCurrencyItem.rate / fromCurrencyItem.nominal) /
                (toCurrencyItem.rate / toCurrencyItem.nominal))
            .toStringAsFixed(1);
  }

  void onToAmountChanged(
    String value,
    CurrencyEntity fromCurrencyItem,
    CurrencyEntity toCurrencyItem,
  ) {
    final amount = double.tryParse(value.replaceAll(',', '.')) ?? 0;

    fromAmountController.text =
        (amount *
                (toCurrencyItem.rate / toCurrencyItem.nominal) /
                (fromCurrencyItem.rate / fromCurrencyItem.nominal))
            .toStringAsFixed(1);
  }

  void onFromCurrencyTap(
    BuildContext context,
    List<CurrencyEntity> currencies,
    CurrencyEntity selectedCurrency,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) => CurrencySelectBottomsheet(
        fromCurrency: fromCurrency,
        currencies: currencies,
        onSelect: (item) {
          if (item == selectedCurrency) return;
          fromAmountController.clear();
          toAmountController.clear();
          context.read<CurrencyCubit>().selectFromCurrency(item);
        },
      ),
    );
  }

  void onToCurrencyTap(
    BuildContext context,
    List<CurrencyEntity> currencies,
    CurrencyEntity selectedCurrency,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) => CurrencySelectBottomsheet(
        fromCurrency: fromCurrency,
        currencies: currencies,
        onSelect: (item) {
          if (item == selectedCurrency) return;
          fromAmountController.clear();
          toAmountController.clear();
          context.read<CurrencyCubit>().selectToCurrency(item);
        },
      ),
    );
  }

  String formatExchangeRate(
    CurrencyEntity fromCurrency,
    CurrencyEntity toCurrency,
  ) {
    final double exchangeRate =
        (fromCurrency.rate / fromCurrency.nominal) /
        (toCurrency.rate / toCurrency.nominal);

    return exchangeRate.toStringAsFixed(4);
  }
}
