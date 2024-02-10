part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  unknown,
}

class AuthenticationBlocState extends Equatable {
  const AuthenticationBlocState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  const AuthenticationBlocState.unknown() : this._();

  const AuthenticationBlocState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationBlocState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];
}
