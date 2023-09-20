import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:login/login/models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>((event, emit) {
      final username = Username.dirty(value: event.username);
      emit(state.copyWith(
        username: username,
        isValid: Formz.validate([username, state.password]),
      ));
    });
    on<LoginPasswordChanged>((event, emit) {
      final password = Password.dirty(value: event.password);
      emit(state.copyWith(
        password: password,
        isValid: Formz.validate([state.username, password]),
      ));
    });
    on<LoginSubmitted>((event, emit) async {
      if (state.isValid) {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
        try {
          await _authenticationRepository.login(
            username: state.username.value,
            password: state.password.value,
          );
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        } catch (e) {
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }
      }
    });
  }
}
