import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Core/Models/UserDataModel.dart';
import 'package:shopapp/Core/Services/remote/DioHelper.dart';
import 'package:shopapp/Cubit/SignUp/RegisterState.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isHide = true;
  IconData suffix = Icons.visibility;

  void changeHide() {
    isHide = !isHide;
    suffix = isHide ? Icons.visibility : Icons.visibility_off;
    emit(ShowText());
  }

  late UserDataModel userDataModel;
  void RegisterUser(
      {required String email,
      required String user,
      required String phone,
      required String password}) {
    emit(LoadingRegisterState());
    DioHelper.postData(
      url: "register",
      query: {
        "email": "$email",
        "name": "$user",
        "phone": "$phone",
        "password": "$password",
      },
    ).then((value) {
      userDataModel = UserDataModel.fromJson(value.data);
      emit(SuccessfulRegisterState(userDataModel));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorRegisterState());
    });
  }
}
