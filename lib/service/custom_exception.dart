class NoInternetConnectionException extends CustomException {
  NoInternetConnectionException() : super("No Internet Connection!");
}

class InternalServerErrorException extends CustomException {
  InternalServerErrorException() : super("Internal Server Error!");
}

class ConnectionTimeoutException extends CustomException {
  ConnectionTimeoutException() : super("Connection Timeout!");
}

class CustomException implements Exception {
  final String message;
  final int? statusCode;
  CustomException(this.message, {this.statusCode});

  @override
  String toString() => message;
}
