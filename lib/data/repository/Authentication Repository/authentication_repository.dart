import '../Authentication%20Repository/authentication_api.dart';

class AuthenticationRepository {
  final AuthenticationAPI _authenticationAPI;

  AuthenticationRepository(this._authenticationAPI);

  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    _authenticationAPI.logInWithEmailAndPassword(
        email: email, password: password);
  }
}
