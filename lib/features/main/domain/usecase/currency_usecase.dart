import 'package:money_converter/common/data/either/either.dart';
import 'package:money_converter/common/data/failure/failures.dart';
import 'package:money_converter/features/main/domain/entity/currency_entity.dart';
import 'package:money_converter/features/main/domain/repository/currency_repository.dart';

class GetCurrenciesUseCase {
  GetCurrenciesUseCase({required this.repository});
  final CurrencyRepository repository;

  Future<Either<Failure, List<CurrencyEntity>>> call() async {
    return await repository.getCurrenies();
  }
}