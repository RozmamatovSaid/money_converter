import 'package:money_converter/core/constant/api_constants.dart';
import 'package:money_converter/core/network/dio_client.dart';
import 'package:money_converter/features/main/data/model/currency_model.dart';

abstract class CurrencyRemoteDataSource {
  Future<List<CurrencyModel>> getCurrenies();
}

class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  CurrencyRemoteDataSourceImpl({required this.dioClient});
  final DioClient dioClient;

  @override
  Future<List<CurrencyModel>> getCurrenies() async {
    final response = await dioClient.dio.get<List<dynamic>>(ApiConstants.baseUrl);
    final data = response.data ?? <dynamic>[];
    return data
        .map(
          (item) => CurrencyModel.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList();
  }
}
