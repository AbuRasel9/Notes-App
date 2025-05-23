///base class for custom exceptions

class AppException implements Exception {
  final _message; //message associated with the exception
  final _prefix; //prefix for the exception
  ///constractor for creatin and [AppException] instance
  ///
  /// The [message]parameter represents the message associated with the exception
  /// and the [_prefix] parameter represents the prefix for the exception
  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_message $_prefix";
  }
}

//email already used
class EmailAlreayUseException extends AppException {
  EmailAlreayUseException([String? message])
      : super(message, "This Email already Used");
}

//Invalid email formate
class InvalidEmailException extends AppException {
  InvalidEmailException([String? message])
      : super(message, "Invalid Email Formate");
}




//password weak
class PasswordWeakException extends AppException {
  PasswordWeakException([String? message])
      : super(message, "Password weak");
}

//user not found
class UserNotFoundException  extends AppException {
  UserNotFoundException([String? message])
      : super(message, "User not found");
}




//email already used
class WrongPasswordException extends AppException {
  WrongPasswordException([String? message])
      : super(message, "Wrong Password");
}

class NoInternetException extends AppException {
  NoInternetException([String? message])
      : super(message, "No Internet Connection");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super(message, "You don't have access to this");
}

class RequestTimeOutException extends AppException {
  RequestTimeOutException([String? message])
      : super(message, "Request Timeout");
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Login Failed");
}
