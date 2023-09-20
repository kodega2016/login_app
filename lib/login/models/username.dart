import 'package:formz/formz.dart';

enum UsernameError { empty }

class Username extends FormzInput<String, UsernameError> {
  const Username.pure() : super.pure('');
  const Username.dirty({String value = ''}) : super.dirty(value);

  @override
  UsernameError? validator(String value) {
    return value.isEmpty ? UsernameError.empty : null;
  }
}
