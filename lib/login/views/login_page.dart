import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:login/dependeny_container.dart';
import 'package:login/login/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => sl<LoginBloc>(),
      child: const LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Login Failure"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (prev, curr) => prev.username != curr.username,
                builder: (context, state) {
                  return TextField(
                    textInputAction: TextInputAction.next,
                    onChanged: (val) => context
                        .read<LoginBloc>()
                        .add(LoginUsernameChanged(username: val)),
                    decoration: InputDecoration(
                      errorText: state.username.displayError != null
                          ? "Username is invalid"
                          : null,
                      labelText: 'Username',
                    ),
                  );
                },
              ),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (prev, curr) => prev.password != curr.password,
                builder: (context, state) {
                  return TextField(
                    textInputAction: TextInputAction.next,
                    onChanged: (val) => context
                        .read<LoginBloc>()
                        .add(LoginPasswordChanged(password: val)),
                    decoration: InputDecoration(
                      errorText: state.password.displayError != null
                          ? "Password is invalid"
                          : null,
                      labelText: 'Password',
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              BlocSelector<LoginBloc, LoginState, bool>(
                selector: (state) {
                  return state.isValid;
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state
                        ? () {
                            context
                                .read<LoginBloc>()
                                .add(const LoginSubmitted());
                          }
                        : null,
                    child: BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (prev, curr) => prev.status != curr.status,
                      builder: (context, state) {
                        return state.status == FormzSubmissionStatus.inProgress
                            ? const CircularProgressIndicator()
                            : const Text('Login');
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
