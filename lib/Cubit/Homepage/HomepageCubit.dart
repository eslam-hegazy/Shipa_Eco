import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Core/Models/HomePageModel.dart';
import 'package:shopapp/Core/Services/remote/DioHelper.dart';
import 'package:shopapp/Cubit/Homepage/HomepageState.dart';
import 'package:shopapp/main.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(InitialHomePageState());
  static HomePageCubit get(context) => BlocProvider.of(context);

  int carentIndex = 0;
  void change(index) {
    carentIndex = index;
    emit(ChangeScreen());
  }

  HomePageModel? homePageModel;
  void getHomeData() {
    emit(LoadingHomePage());
    DioHelper.getData(
      url: "home",
      token: token,
    ).then((value) {
      homePageModel = HomePageModel.fromJson(value.data);
      print(homePageModel!.status);
      // print(homePageModel.data);
      emit(SuccessfulHomePage());
    }).catchError((error) {
      print(error.toString());
    });
  }
}
