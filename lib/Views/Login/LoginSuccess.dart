import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopapp/Views/HomePage/HomePage.dart';
import 'package:shopapp/Widgets/DefaultButton.dart';

class LoginSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Lottie.asset("images/success.json"),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                    return HomePage();
                  }));
                },
                child: DefaultButton("Complete")),
          ),
        ],
      ),
    );
  }
}
