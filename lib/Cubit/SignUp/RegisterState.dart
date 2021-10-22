import 'package:shopapp/Core/Models/UserDataModel.dart';

abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class InitialLoginState extends RegisterState {}

class ShowText extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class SuccessfulRegisterState extends RegisterState {
  final UserDataModel userDataModel;

  SuccessfulRegisterState(this.userDataModel);
}

class ErrorRegisterState extends RegisterState {}
