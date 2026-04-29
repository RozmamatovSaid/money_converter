import 'package:money_converter/common/data/either/either.dart';
import 'package:money_converter/common/data/failure/failures.dart';
import 'package:money_converter/features/main/domain/entity/currency_entity.dart';

abstract class CurrencyRepository {
  Future<Either<Failure, List<CurrencyEntity>>> getCurrenies();
}
