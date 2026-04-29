import 'package:get_it/get_it.dart';
import 'package:money_converter/core/network/dio_client.dart';
import 'package:money_converter/features/main/data/datasource/currency_remote_datasource.dart';
import 'package:money_converter/features/main/data/repository/currency_repository.dart';
import 'package:money_converter/features/main/domain/repository/currency_repository.dart';
import 'package:money_converter/features/main/domain/usecase/currency_usecase.dart';
import 'package:money_converter/features/main/presentation/cubit/currency_cubit.dart';

final GetIt getIt = GetIt.instance;

class DpInjection {
  static Future<void> init() async {
    if (getIt.isRegistered<DioClient>()) {
      return;
    }

    getIt.registerLazySingleton<DioClient>(() => DioClient());
    getIt.registerLazySingleton<CurrencyRemoteDataSource>(
      () => CurrencyRemoteDataSourceImpl(dioClient: getIt()),
    );
    getIt.registerLazySingleton<CurrencyRepository>(
      () => CurrencyRepositoryImpl(remoteDataSource: getIt()),
    );
    getIt.registerLazySingleton<GetCurrenciesUseCase>(
      () => GetCurrenciesUseCase(repository: getIt()),
    );
    getIt.registerFactory<CurrencyCubit>(
      () => CurrencyCubit(currenciesUseCase: getIt<GetCurrenciesUseCase>()),
    );
  }
}
