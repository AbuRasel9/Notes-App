import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class EmailChangeEvent extends AuthEvent {
  final String email;

  const EmailChangeEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class PasswordChangeEvent extends AuthEvent {
  final String password;

  const PasswordChangeEvent({required this.password});

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {}

class RegistrationEvent extends AuthEvent {}
class LogoutEvent extends AuthEvent{}
