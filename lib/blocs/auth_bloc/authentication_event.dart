part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}
