import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Core/Services/local/Cachehelper.dart';
import 'package:shopapp/Cubit/Homepage/HomepageCubit.dart';
import 'package:shopapp/Cubit/Login/LoginCubit.dart';
import 'package:shopapp/Cubit/OnBoarding/OnBoardingCubit.dart';
import 'package:shopapp/Cubit/SignUp/RegisterCubit.dart';
import 'package:shopapp/Views/HomePage/HomePage.dart';
import 'package:shopapp/Views/Login/Login.dart';

import 'Core/Services/remote/DioHelper.dart';
import 'MyBlocObserver.dart';
import 'Views/OnBoarding/OnBoarding.dart';

var token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoard = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: "token");
  Widget widget;
  if (onBoard != null) {
    if (token != null)
      widget = HomePage();
    else
      widget = Login();
  } else {
    widget = onBoarding();
  }
  runApp(MyApp(onBoard, widget));
}

class MyApp extends StatelessWidget {
  final bool onBoard;
  final Widget screen;
  MyApp(this.onBoard, this.screen);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => HomePageCubit(),
        ),
      ],
      child: MaterialApp(
        title: "My App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.red,
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backwardsCompatibility: false,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            textTheme: TextTheme(
              body1: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans",
              ),
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
        ),
        themeMode: ThemeMode.light,
        home: screen,
      ),
    );
  }
}
