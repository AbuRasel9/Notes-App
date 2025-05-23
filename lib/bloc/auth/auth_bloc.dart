import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/bloc/auth/auth_event.dart';
import 'package:bloc_clean_architecture/bloc/auth/auth_state.dart';
import 'package:bloc_clean_architecture/repository/auth_repository/auth_repository.dart';
import 'package:bloc_clean_architecture/repository/auth_repository/auth_repository_impl.dart';
import 'package:bloc_clean_architecture/utils/enum/font_option.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository = AuthRepositoryImpl();

  AuthBloc() : super(AuthState()) {
    on<EmailChangeEvent>(_emailChange);
    on<PasswordChangeEvent>(_paswordChange);
    on<LoginEvent>(_login);
    on<RegistrationEvent>(_registration);
    on<LogoutEvent>(_logout);
  }

  //email change function
  void _emailChange(EmailChangeEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email));
  }

  //password Change function
  void _paswordChange(PasswordChangeEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  //login submit button click
  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    await authRepository.login(state.email, state.password).then(
      (value) {
        emit(state.copyWith(apiStatus: ApiStatus.success));
      },
    ).onError(
      (error, stackTrace) {
        emit(state.copyWith(
            apiStatus: ApiStatus.error, message: error.toString()));
      },
    );
  }

  //login submit button click
  Future<void> _registration(
      RegistrationEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    await authRepository.registration(state.email, state.password).then(
      (value) {
        emit(state.copyWith(apiStatus: ApiStatus.success));
      },
    ).onError(
      (error, stackTrace) {
        emit(state.copyWith(
            apiStatus: ApiStatus.error, message: error.toString()));
      },
    );
  }

  //login submit button click
  Future<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));

    await authRepository.logout().then((value) {
      emit(state.copyWith(apiStatus: ApiStatus.logout));
    },).onError(
      (error, stackTrace) {
        emit(state.copyWith(
          apiStatus: ApiStatus.error,
             message: error.toString()));
      },
    );
  }
}
