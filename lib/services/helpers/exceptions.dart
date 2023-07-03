///***************************************************************************
/// AppException
///***************************************************************************
class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

///***************************************************************************
/// FetchDataException
///***************************************************************************
class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "Error during communication: ");
}

///***************************************************************************
/// BadDataException
///***************************************************************************
class BadDataException extends AppException {
  BadDataException([String? message]) : super(message, "Invalid Request: ");
}

///***************************************************************************
/// UnauthorizedDataException
///***************************************************************************
class UnauthorizedDataException extends AppException {
  UnauthorizedDataException([String? message]) : super(message, "Unauthorized: ");
}

///***************************************************************************
/// InvalidInputException
///***************************************************************************
class InvalidDataException extends AppException {
  InvalidDataException([String? message]) : super(message, "Invalid Input: ");
}
