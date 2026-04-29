part of 'currency_cubit.dart';

class CurrencyState extends Equatable {
  const CurrencyState({
    this.status = Status.initial,
    this.message = '',
    this.currencies = const [],
    this.selectedFromCurrency,
    this.selectedToCurrency,
    this.isSwap = false,
  });
  final Status status;
  final String message;
  final List<CurrencyEntity> currencies;
  final CurrencyEntity? selectedFromCurrency;
  final CurrencyEntity? selectedToCurrency;
  final bool isSwap;

  CurrencyState copyWith({
    Status? status,
    String? message,
    List<CurrencyEntity>? currencies,
    CurrencyEntity? selectedFromCurrency,
    CurrencyEntity? selectedToCurrency,
    bool clearSelectedFromCurrency = false,
    bool clearSelectedToCurrency = false,
    bool? isSwap,
  }) {
    return CurrencyState(
      status: status ?? this.status,
      message: message ?? this.message,
      currencies: currencies ?? this.currencies,
      selectedFromCurrency: clearSelectedFromCurrency
          ? null
          : (selectedFromCurrency ?? this.selectedFromCurrency),
      selectedToCurrency: clearSelectedToCurrency
          ? null
          : (selectedToCurrency ?? this.selectedToCurrency),
      isSwap: isSwap ?? this.isSwap,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    currencies,
    selectedFromCurrency,
    selectedToCurrency,
    isSwap,
  ];
}
