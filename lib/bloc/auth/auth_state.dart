import 'package:bloc_clean_architecture/utils/enum/font_option.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  AuthState(
      {this.message = "",
      this.apiStatus = ApiStatus.initial,
      this.password = "",
      this.email = ""});

  final String message, email, password;
  final ApiStatus apiStatus;

  AuthState copyWith({String? message, email, password, ApiStatus? apiStatus}) {
    return AuthState(
      message: message ?? this.message,
      email: email ?? this.email,
      password: password ?? this.password,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }

  @override
  List<Object?> get props => [
        message,
        email,
        password,
        apiStatus,
      ];
}
