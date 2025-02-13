abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  final String message;

  RegisterErrorState({required this.message});
}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  final String message;

  LoginErrorState({required this.message});
}

class LogoutLoadingState extends AuthStates {}

class LogoutSuccessState extends AuthStates {}

class LogoutErrorState extends AuthStates {
  final String errMsg;

  LogoutErrorState({required this.errMsg});
}
