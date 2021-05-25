import 'package:flutter/material.dart';

import 'colours.dart';

abstract class ButtonStyles {
  static ButtonStyle button1 = ButtonStyle(
    elevation: MaterialStateProperty.all(5),
    padding: MaterialStateProperty.all(EdgeInsets.all(15)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static ButtonStyle button2 = ButtonStyle(
    elevation: MaterialStateProperty.all(5),
    shadowColor: MaterialStateProperty.all(Color.fromRGBO(106, 147, 71, 1)),
    padding: MaterialStateProperty.all(EdgeInsets.all(15)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(106, 147, 71, 1)),
  );

  static ButtonStyle button2brown = ButtonStyle(
    elevation: MaterialStateProperty.all(5),
    shadowColor: MaterialStateProperty.all(Colors.brown),
    padding: MaterialStateProperty.all(EdgeInsets.all(15)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(Colors.brown),
  );

  static ButtonStyle button3 = ButtonStyle(
    elevation: MaterialStateProperty.all(5),
    shadowColor: MaterialStateProperty.all(Color.fromRGBO(225, 160, 103, 1)),
    padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(15, 7.5, 15, 7.5)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    backgroundColor:
        MaterialStateProperty.all(Color.fromRGBO(225, 160, 103, 1)),
  );

  static ButtonStyle circle = ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    ),
  );

  static ButtonStyle cart = ButtonStyle(
    elevation: MaterialStateProperty.all(15),
    shadowColor: MaterialStateProperty.all(
      CustomColors.lightGreen,
    ),
    padding: MaterialStateProperty.all(
      EdgeInsets.all(20),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(
      CustomColors.green,
    ),
  );

  static ButtonStyle categoryActive = ButtonStyle(
    elevation: MaterialStateProperty.all(15),
    shadowColor: MaterialStateProperty.all(
      CustomColors.lightOrange,
    ),
    padding: MaterialStateProperty.all(
      EdgeInsets.all(20),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(
      CustomColors.orange,
    ),
  );

  static ButtonStyle categoryIdle = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(
      EdgeInsets.all(20),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: CustomColors.darkPeach,
          width: 1.5,
        ),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(
      Colors.transparent,
    ),
  );

  static ButtonStyle unstyled = ButtonStyle(
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    overlayColor: MaterialStateProperty.all(Colors.transparent),
  );
}
