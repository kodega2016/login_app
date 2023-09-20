import 'package:authentication_repository/authentication_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:login/authentication/bloc/authentication_bloc.dart';
import 'package:login/login/bloc/login_bloc.dart';
import 'package:user_repository/user_repository.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(),
  );

  sl.registerLazySingleton<UserRepository>(() => UserRepository());

  sl.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(
      authenticationRepository: sl(),
      userRepository: sl(),
    ),
  );

  sl.registerFactory<LoginBloc>(
    () => LoginBloc(authenticationRepository: sl()),
  );
}
