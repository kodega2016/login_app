import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationRepository {
  Future<void> login({
    required String username,
    required String password,
  });

  Future<void> logut();
  Stream<AuthenticationStatus> get status;
  void dispose();
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  @override
  Future<void> login({
    required String username,
    required String password,
  }) async {
    await Future.delayed(Duration(milliseconds: 300));
    _controller.add(AuthenticationStatus.authenticated);
  }

  @override
  Future<void> logut() async {
    await Future.delayed(Duration(milliseconds: 300));
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future.delayed(Duration(milliseconds: 300));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
  }
}
