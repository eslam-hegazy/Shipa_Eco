import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/Cubit/Login/LoginCubit.dart';
import 'package:shopapp/Cubit/Login/LoginState.dart';
import 'package:shopapp/Views/Login/LoginSuccess.dart';
import 'package:shopapp/Widgets/DefaultButton.dart';
import 'package:shopapp/Widgets/NameSpace.dart';

class ResetPassword extends StatelessWidget {
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  final String code;

  ResetPassword(this.code);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            padding: EdgeInsets.only(right: 25, left: 25),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: Lottie.asset("images/reset-password-recycle.json"),
                    ),
                    Text(
                      "Reset Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "PatuaOne",
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "From Previous Used Password",
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    NameSpace("New Password"),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter New Password";
                          }
                          return null;
                        },
                        obscureText: cubit.isHide,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          prefixIcon: Icon(
                            LineIcons.lock,
                            color: Colors.black54,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changeHide();
                            },
                            icon: Icon(
                              cubit.suffix,
                              color: Colors.black54,
                            ),
                          ),
                          fillColor: Colors.grey.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          cubit.resetPassword(
                              code: code, password: passwordController.text);
                        }
                      },
                      child: DefaultButton("Reset Password"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SuccessfulResetPassword) {
          if (state.userDataModel.status!) {
            showToast(
              state.userDataModel.message,
              context: context,
              backgroundColor: Colors.red,
              position: StyledToastPosition.center,
              borderRadius: BorderRadius.circular(15),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) {
                return LoginSuccess();
              }),
            );
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
