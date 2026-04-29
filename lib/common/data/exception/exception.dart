final class AuthException implements Exception {
  const AuthException(this.message, {this.code});

  final String message;
  final int? code;

  @override
  String toString() => message;
}
