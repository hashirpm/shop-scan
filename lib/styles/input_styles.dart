import 'package:flutter/material.dart';

import 'colours.dart';

abstract class InputStyles {
  static InputDecoration username = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(99, 56, 32, 1),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
    ),
    hintText: "Username",
  );

  static InputDecoration email = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(99, 56, 32, 1),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
    ),
    hintText: "Email",
  );

  static InputDecoration password(Widget suffixIcon) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(99, 56, 32, 1),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      hintText: "Password",
      suffixIcon: suffixIcon,
    );
  }

  static InputDecoration search = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: CustomColors.darkPeach,
        width: 3,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: CustomColors.darkPeach,
        width: 3,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    hintText: "Search for products",
    hintStyle: TextStyle(
        color: CustomColors.orange, fontSize: 17, fontFamily: "Poppins"),
    prefixIcon: Icon(
      Icons.search,
      color: CustomColors.orange,
      size: 30,
    ),
    suffixIcon: Icon(
      Icons.mic_none,
      color: CustomColors.orange,
      size: 30,
    ),
  );

  static InputDecoration profileFields(String hint) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.orange,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.orange,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      hintText: hint,
      hintStyle: TextStyle(
          color: CustomColors.orange, fontSize: 17, fontFamily: "Poppins"),
    );
  }
}
