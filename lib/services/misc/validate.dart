abstract class Validate {
  static String? name(String? value) {
    if (value!.isEmpty)
      return "Name required !";
    else
      return null;
  }

  static String? email(String? value) {
    if (value!.isEmpty)
      return "Email required !";
    else if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value))
      return "Enter valid email";
    else
      return null;
  }

  static String? password(String? value) {
    if (value!.isEmpty)
      return "Password required !";
    else if (value.length < 6)
      return "Password must contain minimum 6 characters !";
    else if (!RegExp(r"^(?=.*?[a-z]).{6,}$").hasMatch(value))
      return "At least one small letter required !";
    else if (!RegExp(r"^(?=.*?[A-Z]).{6,}$").hasMatch(value))
      return "At least one capital letter required !";
    else if (!RegExp(r"^(?=.*?[0-9]).{6,}$").hasMatch(value))
      return "At least one digit required !";
    else if (!RegExp(r"^(?=.*?[!@#\$&*~]).{6,}$").hasMatch(value))
      return "At least one special character required !";
    else
      return null;
  }

  static bool isNumber(String value) {
    try {
      int.parse(value);
      return true;
    } on FormatException {
      return false;
    }
  }

  static String? phone(String? value) {
    bool valid = isNumber(value.toString());
    if (value!.isEmpty)
      return "Phone number required !";
    else if (!valid)
      return "Must be a number!";
    else if (value.length != 10)
      return "Phone no must have 10 digits";
    else
      return null;
  }

  static String? pin(String? value) {
    bool valid = isNumber(value.toString());
    if (value!.isEmpty)
      return "Pin code required !";
    else if (!valid)
      return "Must be a number !";
    else if (value.length != 6)
      return "Pin code must have 6 digits";
    else
      return null;
  }

  static String? notEmpty(String value, String label) {
    if (value.isEmpty)
      return "$label required !";
    else
      return null;
  }
}
