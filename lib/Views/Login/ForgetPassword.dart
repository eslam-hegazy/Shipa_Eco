import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/Cubit/Login/LoginCubit.dart';
import 'package:shopapp/Cubit/Login/LoginState.dart';
import 'package:shopapp/Views/Login/PinCode.dart';
import 'package:shopapp/Widgets/DefaultButton.dart';
import 'package:shopapp/Widgets/DefaultTextForm.dart';

class ForgetPassword extends StatelessWidget {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.only(right: 25, left: 25),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Lottie.asset('images/forgot-password.json'),
                    ),
                    Text(
                      "Reset Password !",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PatuaOne",
                          fontWeight: FontWeight.w900,
                          fontSize: 35),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Please enter your email address",
                      style: TextStyle(
                        fontFamily: "BalsamiqSans",
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DefaultTextForm(
                        Icons.email_outlined,
                        "Email",
                        "Please Enter Your Email",
                        emailController,
                        TextInputType.emailAddress),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          cubit.verifyEmailAddress(email: emailController.text);
                        }
                      },
                      child: DefaultButton("Send"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SuccessfulVerifyEmail) {
          if (state.userDataModel.status!) {
            print(state.userDataModel.message);
            showToast(
              state.userDataModel.message,
              context: context,
              backgroundColor: Colors.blue,
              position: StyledToastPosition.bottom,
              borderRadius: BorderRadius.circular(15),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) {
                return PinCode();
              }),
            );
          } else {
            print(state.userDataModel.message);
            showToast(
              state.userDataModel.message,
              context: context,
              backgroundColor: Colors.red,
              position: StyledToastPosition.bottom,
              borderRadius: BorderRadius.circular(15),
            );
          }
        }
      },
    );
  }
}
