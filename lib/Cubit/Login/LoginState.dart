import 'package:shopapp/Core/Models/UserDataModel.dart';

abstract class LoginState {}

class InitialLoginState extends LoginState {}

class ShowText extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessfulLoginState extends LoginState {
  final UserDataModel userDataModel;

  SuccessfulLoginState(this.userDataModel);
}

class ErrorLoginState extends LoginState {}

class LoadingVerifyEmail extends LoginState {}

class SuccessfulVerifyEmail extends LoginState {
  final UserDataModel userDataModel;

  SuccessfulVerifyEmail(this.userDataModel);
}

class ErrorVerifyEmail extends LoginState {}

class LoadingVerifyCode extends LoginState {}

class SuccessfulVerifyCode extends LoginState {
  final UserDataModel userDataModel;

  SuccessfulVerifyCode(this.userDataModel);
}

class ErrorVerifyCode extends LoginState {}

class LoadingResetPassword extends LoginState {}

class SuccessfulResetPassword extends LoginState {
  final UserDataModel userDataModel;

  SuccessfulResetPassword(this.userDataModel);
}

class ErrorResetPassword extends LoginState {}
