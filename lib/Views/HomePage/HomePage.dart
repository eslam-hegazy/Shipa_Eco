import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Cubit/Homepage/HomepageCubit.dart';
import 'package:shopapp/Cubit/Homepage/HomepageState.dart';
import 'package:shopapp/Views/HomePage/Screens/Category.dart';
import 'package:shopapp/Views/HomePage/Screens/Favorite.dart';
import 'package:shopapp/Views/HomePage/Screens/Home.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import 'Screens/Settings.dart';

class HomePage extends StatelessWidget {
  late PageController controller;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);
        controller = PageController(initialPage: cubit.carentIndex);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "ShopApp",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "BalsamiqSans",
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
            ],
          ),
          bottomNavigationBar: SlidingClippedNavBar(
            backgroundColor: Colors.white,
            inactiveColor: Colors.black,
            onButtonPressed: (index) {
              cubit.change(index);
              controller.animateToPage(cubit.carentIndex,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutQuad);
            },
            iconSize: 25,
            activeColor: Colors.black,
            selectedIndex: cubit.carentIndex,
            barItems: [
              BarItem(
                icon: Icons.home,
                title: 'Home',
              ),
              BarItem(
                icon: Icons.category,
                title: 'Category',
              ),
              BarItem(
                icon: Icons.favorite,
                title: 'Favorite',
              ),
              BarItem(
                icon: Icons.settings,
                title: 'Settings',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // CacheHelper.removeData(key: "token").then((value) {
              //   Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (_) {
              //     return Login();
              //   }));
              // });
              cubit.getHomeData();
            },
            child: Icon(Icons.ac_unit_sharp),
          ),
          body: PageView(
            physics: BouncingScrollPhysics(),
            controller: controller,
            children: [
              Home(),
              Category(),
              Favorite(),
              Setting(),
            ],
          ),
        );
      },
    );
  }
}
