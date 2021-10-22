import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultTextForm extends StatelessWidget {
  final IconData? perfixIcon;
  final String? hint, error;
  final TextEditingController? controller;
  final TextInputType? type;

  DefaultTextForm(
    this.perfixIcon,
    this.hint,
    this.error,
    this.controller,
    this.type,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        validator: (value) {
          if (value!.isEmpty) {
            return error;
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: "OpenSans",
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            perfixIcon,
            color: Colors.black54,
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
    );
  }
}
