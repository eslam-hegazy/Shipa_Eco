import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextHelp extends StatelessWidget {
  final Function press;

  TextHelp(this.press);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () => press,
        child: Text(
          " Need Some Help? ",
          style: TextStyle(
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.solid,
            decorationColor: Colors.black,
            fontFamily: "BalsamiqSans",
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
