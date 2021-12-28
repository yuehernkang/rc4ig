import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationStatus> {
  AuthenticationBloc() : super(AuthenticationStatus.unauthenticated) {
    on<AuthenticationEvent>((event, emit) {});
  }
}
