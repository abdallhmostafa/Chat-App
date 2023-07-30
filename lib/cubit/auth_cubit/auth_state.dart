abstract class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class LoginInitialState extends AuthenticationState {}


class LoginSuccessState extends AuthenticationState {}

class LoginLoadingState extends AuthenticationState {}

class LoginFailureState extends AuthenticationState {
  String erorrMessage;
  LoginFailureState({required this.erorrMessage});

}

class SignInInitialState extends AuthenticationState {}

class SignInSuccessState extends AuthenticationState {}

class SignInLoadingState extends AuthenticationState {}

class SignInFailureState extends AuthenticationState {
  final String errorMessage;
  SignInFailureState({required this.errorMessage});
}
