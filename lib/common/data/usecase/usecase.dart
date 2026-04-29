import 'dart:async';

import 'package:dio/dio.dart';

import '../../extraction/extraction.dart';

abstract class UseCase<R, P> {
  const UseCase();

  Future<T> handle<T>(
    FutureOr<T> Function() action, {
    required FutureOr<T> Function(ApiErrorDetails exception) onApiError,
    required FutureOr<T> Function(Object error) onError,
  }) async {
    try {
      return await action();
    } on DioException catch (e) {
      final apiError = extractDioApiError(e);
      if (apiError != null) {
        return await onApiError(apiError);
      } else {
        return await onError(e);
      }
    } on Object catch (e) {
      return await onError(e);
    }
  }

  Future<R> call(P params);
}

final class NoParams {
  const NoParams();

  @override
  bool operator ==(Object other) => other is NoParams;

  @override
  int get hashCode => 0;
}
