import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  final Dio dio;
  DioClient()
    : dio = Dio(
        BaseOptions(
          // baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("➡️ ${options.method} ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("✅ ${response.statusCode} ${response.requestOptions.uri}");
          return handler.next(response);
        },
        onError: (e, handler) {
          debugPrint("ERROR: ${e.message}");

          return handler.next(e);
        },
      ),
    );
  }
}
