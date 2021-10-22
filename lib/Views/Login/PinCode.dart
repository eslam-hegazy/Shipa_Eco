import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shopapp/Cubit/Login/LoginCubit.dart';
import 'package:shopapp/Cubit/Login/LoginState.dart';
import 'package:shopapp/Views/Login/ResetPassword.dart';
import 'package:shopapp/Widgets/DefaultButton.dart';

class PinCode extends StatelessWidget {
  late String? code;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  alignment: Alignment.center,
                  child: Lottie.asset("images/change-passwords.json"),
                ),
                Text(
                  "Verification",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "PatuaOne",
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                Text(
                  "Enter your OTP code number",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 40, left: 40, top: 35, bottom: 20),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    onChanged: (value) {
                      print(value);
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      activeColor: Colors.blue,
                      activeFillColor: Colors.grey,
                      inactiveColor: Colors.black,
                      selectedColor: Colors.grey,
                      fieldHeight: 70,
                      fieldWidth: 70,
                    ),
                    onCompleted: (value) {
                      code = value;
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    cubit.verifyCode(code: code.toString());
                  },
                  child: DefaultButton("Verify"),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SuccessfulVerifyCode) {
          if (state.userDataModel.status!) {
            showToast(
              "Verification",
              context: context,
              backgroundColor: Colors.blue,
              position: StyledToastPosition.center,
              borderRadius: BorderRadius.circular(15),
            );
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ResetPassword(code.toString());
            }));
          } else {
            showToast(
              state.userDataModel.message,
              context: context,
              backgroundColor: Colors.red,
              position: StyledToastPosition.center,
              borderRadius: BorderRadius.circular(15),
            );
          }
        }
      },
    );
  }
}
