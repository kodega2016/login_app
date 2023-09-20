import 'package:user_repository/src/models/user.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) {
      return _user;
    }
    await Future.delayed(Duration(seconds: 1));
    return User(id: Uuid().v4());
  }
}
