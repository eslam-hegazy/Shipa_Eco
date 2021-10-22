import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Core/Models/OnBoardingModel.dart';
import 'package:shopapp/Cubit/OnBoarding/OnBoardingState.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(InitialOnBoardingState());
  static OnBoardingCubit get(context) => BlocProvider.of(context);
  List<OnBoardingModel> board = [
    OnBoardingModel("images/shop1.json", "OnLine Cart",
        "Select Memorize Your Future Pur-Chases With Smart Online Shopping Card."),
    OnBoardingModel("images/shop2.json", "Sales And Gifts",
        "Holiday Sales. Birthday Gifts. Various Choice And Categories"),
    OnBoardingModel("images/shop3.json", "Client Reviews",
        "Honest FeedBacks From Our Clients. Happy Clients - Happy Us."),
  ];
}
