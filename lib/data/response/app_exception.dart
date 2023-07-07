class AppException implements Exception {
  final prefix;
  final message;

  AppException({this.prefix, this.message});
  @override
  String toString() {
    return '$prefix $message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message: message, prefix: 'Error During Comminucation');
}

class BadRequestException extends AppException {
  BadRequestException([String? message])
      : super(message: message, prefix: 'Invalid Request');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super(message: message, prefix: 'Unauthorized Request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message: message, prefix: 'Invalid Input');
}
