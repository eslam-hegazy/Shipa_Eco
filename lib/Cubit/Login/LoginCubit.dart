import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Core/Models/UserDataModel.dart';
import 'package:shopapp/Core/Services/remote/DioHelper.dart';
import 'package:shopapp/Cubit/Login/LoginState.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool isHide = true;
  IconData suffix = Icons.visibility;

  void changeHide() {
    isHide = !isHide;
    suffix = isHide ? Icons.visibility : Icons.visibility_off;
    emit(ShowText());
  }

  UserDataModel? userDataModel;
  void LoginUser({
    required String email,
    required String password,
  }) {
    emit(LoadingLoginState());
    DioHelper.postData(
      url: "login",
      query: {
        "email": "$email",
        "password": "$password",
      },
    ).then((value) {
      userDataModel = UserDataModel.fromJson(value.data!);

      // print(value.data['message']);
      // print(value.data['status']);
      emit(SuccessfulLoginState(userDataModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLoginState());
    });
  }

  UserDataModel? verifyEmail;
  void verifyEmailAddress({required String email}) {
    emit(LoadingVerifyEmail());
    DioHelper.postData(
      url: "verify-email",
      query: {
        "email": "$email",
      },
    ).then((value) {
      verifyEmail = UserDataModel.fromJson(value.data);
      emit(SuccessfulVerifyEmail(verifyEmail!));
    }).catchError((error) {
      emit(ErrorVerifyEmail());
      print(error.toString());
    });
  }

  UserDataModel? codeVerify;
  void verifyCode({required String code}) {
    emit(LoadingVerifyCode());
    DioHelper.postData(
      url: "verify-code",
      query: {
        "email": "${verifyEmail!.data!.email}",
        "code": "$code",
      },
    ).then((value) {
      codeVerify = UserDataModel.fromJson(value.data);
      emit(SuccessfulVerifyCode(codeVerify!));
    }).catchError((error) {
      emit(ErrorVerifyCode());
      print(error.toString());
    });
  }

  UserDataModel? restPassword;
  void resetPassword({required String code, required String password}) {
    emit(LoadingResetPassword());
    DioHelper.postData(
      url: "reset-password",
      query: {
        "email": "${codeVerify!.data!.email}",
        "code": "$code",
        "password": "$password",
      },
    ).then((value) {
      emit(SuccessfulResetPassword(restPassword!));
      restPassword = UserDataModel.fromJson(value.data);
    }).catchError((error) {
      emit(ErrorResetPassword());
      print(error.toString());
    });
  }
}
