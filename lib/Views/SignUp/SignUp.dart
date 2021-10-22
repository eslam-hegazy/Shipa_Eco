import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/Core/Services/local/Cachehelper.dart';
import 'package:shopapp/Cubit/SignUp/RegisterCubit.dart';
import 'package:shopapp/Cubit/SignUp/RegisterState.dart';
import 'package:shopapp/Views/HomePage/HomePage.dart';
import 'package:shopapp/Views/Login/Login.dart';
import 'package:shopapp/Widgets/DefaultButton.dart';
import 'package:shopapp/Widgets/DefaultTextForm.dart';
import 'package:shopapp/Widgets/NameSpace.dart';
import 'package:shopapp/Widgets/TextHelp.dart';

class SignUp extends StatelessWidget {
  var emailController = TextEditingController();
  var userController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is SuccessfulRegisterState) {
          if (state.userDataModel.status!) {
            print(state.userDataModel.message);
            showToast(
              state.userDataModel.message,
              context: context,
              backgroundColor: Colors.blue,
              position: StyledToastPosition.center,
              borderRadius: BorderRadius.circular(15),
            );
            CacheHelper.putData(
                    key: "token", value: state.userDataModel.data!.token)
                .then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) {
                  return HomePage();
                }),
              );
            }).catchError((error) {
              print(error.toString());
            });
          } else {
            print(state.userDataModel.message);
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
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Lottie.asset('images/welcome.json'),
                        ),
                        Text(
                          "Let's Get Started",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "PatuaOne",
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                        Text(
                          "Sign up and we will continue",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        NameSpace("Email"),
                        DefaultTextForm(
                          Icons.email_outlined,
                          "*********@gmail.com",
                          "Please Enter Email",
                          emailController,
                          TextInputType.emailAddress,
                        ),
                        NameSpace("Username"),
                        DefaultTextForm(
                          Icons.person_outline_rounded,
                          "uimsjds015",
                          "Please Enter Username",
                          userController,
                          TextInputType.name,
                        ),
                        NameSpace("Phone"),
                        DefaultTextForm(
                          LineIcons.phone,
                          "01**********",
                          "Please Enter Phone",
                          phoneController,
                          TextInputType.phone,
                        ),
                        NameSpace("Password"),
                        Padding(
                          padding: const EdgeInsets.all(13),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Password";
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
                              cubit.RegisterUser(
                                  email: emailController.text,
                                  user: userController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text);
                            }
                          },
                          child: DefaultButton("Sign Up"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontFamily: "PatuaOne",
                                fontSize: 15,
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (_) {
                                    return Login();
                                  },
                                ));
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "BalsamiqSans",
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextHelp(() {}),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
