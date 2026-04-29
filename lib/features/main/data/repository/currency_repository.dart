import 'package:money_converter/common/data/either/either.dart';
import 'package:money_converter/common/data/failure/failures.dart';
import 'package:money_converter/features/main/data/datasource/currency_remote_datasource.dart';
import 'package:money_converter/features/main/domain/entity/currency_entity.dart';
import 'package:money_converter/features/main/domain/repository/currency_repository.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  CurrencyRepositoryImpl({required this.remoteDataSource});
  final CurrencyRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<CurrencyEntity>>> getCurrenies() async {
    try {
      final result = await remoteDataSource.getCurrenies();
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
