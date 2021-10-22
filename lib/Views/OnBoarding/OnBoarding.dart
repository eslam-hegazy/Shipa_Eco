import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/Core/Services/local/Cachehelper.dart';
import 'package:shopapp/Cubit/OnBoarding/OnBoardingCubit.dart';
import 'package:shopapp/Cubit/OnBoarding/OnBoardingState.dart';
import 'package:shopapp/Views/Login/Login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoarding extends StatelessWidget {
  PageController boardController = PageController();
  bool isLast = false;
  void submit(context) {
    CacheHelper.putData(key: "onBoarding", value: true).then((value) {
      if (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) {
            return Login();
          }),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        var board = OnBoardingCubit.get(context).board;
        return Scaffold(
          appBar: AppBar(
            actions: [
              FlatButton(
                onPressed: () {
                  submit(context);
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: boardController,
                    onPageChanged: (index) {
                      if (index == board.length - 1) {
                        isLast = true;
                      }
                    },
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.50,
                            child: Lottie.asset("${board[index].image}"),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "${board[index].title}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Rubik",
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${board[index].description}",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: board.length,
                  ),
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5,
                      ),
                      controller: boardController,
                      count: board.length,
                    ),
                    Spacer(),
                    FloatingActionButton(
                      autofocus: false,
                      onPressed: () {
                        if (isLast == false) {
                          boardController.nextPage(
                              duration: Duration(microseconds: 750),
                              curve: Curves.fastLinearToSlowEaseIn);
                        } else {
                          submit(context);
                        }
                      },
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
