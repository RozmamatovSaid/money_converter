import 'package:dio/dio.dart';

const String _fallbackRequestFailedMessage = 'Request failed';

final class ApiErrorDetails {
  const ApiErrorDetails({required this.message, this.code});

  final String message;
  final int? code;
}

Map<String, Object?> nestedResponsePayload(Map<String, Object?> json) {
  final data = asMap(json['data']);
  final nestedData = asMap(data['data']);

  if (nestedData.isNotEmpty) return nestedData;
  if (data.isNotEmpty) return data;
  return json;
}

String? extractErrorMessage(Map<String, Object?> json, {int? statusCode}) =>
    extractApiError(json, statusCode: statusCode)?.message;

ApiErrorDetails? extractApiError(Map<String, Object?> json, {int? statusCode}) {
  final data = asMap(json['data']);
  final payload = asMap(data['data']);
  final code = _asInt(payload['err_code']);

  if (json['custom_message'] case final String customMessage when customMessage.isNotEmpty) {
    return ApiErrorDetails(message: customMessage, code: code);
  }
  if (data['server_error'] case final String serverError when serverError.isNotEmpty) {
    return ApiErrorDetails(message: serverError, code: code);
  }
  if (!_isApiError(payload, statusCode: statusCode)) return null;

  if (payload['message'] case final String message when message.isNotEmpty) {
    return ApiErrorDetails(message: message, code: code);
  }
  return ApiErrorDetails(message: _fallbackRequestFailedMessage, code: code);
}

ApiErrorDetails? extractDioApiError(DioException exception) {
  final responseData = exception.response?.data;
  final json = responseData is Map<Object?, Object?> ? Map<String, Object?>.from(responseData) : null;

  return json != null
      ? extractApiError(json, statusCode: exception.response?.statusCode) ??
            ApiErrorDetails(message: exception.message ?? _fallbackRequestFailedMessage)
      : ApiErrorDetails(message: exception.message ?? _fallbackRequestFailedMessage);
}

String extractDioErrorMessage(DioException exception) =>
    extractDioApiError(exception)?.message ?? _fallbackRequestFailedMessage;

DioException responseException({
  required Map<String, Object?> json,
  required RequestOptions requestOptions,
  Response<dynamic>? response,
}) {
  final details = extractApiError(json, statusCode: response?.statusCode);
  return DioException(
    requestOptions: requestOptions,
    response: response,
    type: .badResponse,
    error: details,
    message: details?.message ?? _fallbackRequestFailedMessage,
  );
}

Map<String, Object?> asMap(Object? value) {
  if (value is Map<Object?, Object?>) return .from(value);
  return <String, Object?>{};
}

void throwIfApiError(Map<String, Object?> json, Response<dynamic> response) {
  if (extractApiError(json, statusCode: response.statusCode) != null) {
    throw responseException(json: json, requestOptions: response.requestOptions, response: response);
  }
}

bool _isApiError(Map<String, Object?> payload, {int? statusCode}) {
  if (statusCode != null && statusCode >= 400) return true;
  return payload['error'] == true || _asInt(payload['err_code']) != null;
}

int? _asInt(Object? value) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}
