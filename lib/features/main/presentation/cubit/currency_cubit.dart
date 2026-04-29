import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_converter/common/data/enums/bloc_status_enum.dart';
import 'package:money_converter/features/main/domain/entity/currency_entity.dart';
import 'package:money_converter/features/main/domain/usecase/currency_usecase.dart';

part 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit({required this.currenciesUseCase}) : super(CurrencyState());
  final GetCurrenciesUseCase currenciesUseCase;

  Future<void> getCurrencies() async {
    emit(state.copyWith(status: Status.loading));

    final result = await currenciesUseCase.call();

    result.fold(
      onLeft: (error) =>
          emit(state.copyWith(status: Status.error, message: error.toString())),
      onRight: (response) =>
          emit(state.copyWith(status: Status.success, currencies: response)),
    );
  }

  void selectFromCurrency(CurrencyEntity currency) {
    emit(state.copyWith(selectedFromCurrency: currency));
  }

  void selectToCurrency(CurrencyEntity currency) {
    emit(state.copyWith(selectedToCurrency: currency));
  }

  void swapConverterField() async {
    emit(state.copyWith(isSwap: !state.isSwap));
  }
}
