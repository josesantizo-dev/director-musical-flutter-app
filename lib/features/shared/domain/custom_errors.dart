class ConnectionError implements Exception {}

class InvalidCredentials implements Exception {}

class GoogleLoginCancelled implements Exception {}

class CustomError implements Exception {
  final String message;

  CustomError(this.message);
}
