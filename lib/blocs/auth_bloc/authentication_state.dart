part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated
}

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    required this.status,
    this.user = User.empty,
  });

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object?> get props =>  [status, user];

}