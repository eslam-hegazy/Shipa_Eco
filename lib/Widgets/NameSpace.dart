import 'package:flutter/cupertino.dart';

class NameSpace extends StatelessWidget {
  final String? text;

  NameSpace(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "$text",
        style: TextStyle(
          fontFamily: "Rubik",
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
