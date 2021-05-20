import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopscan/screens/qr_reader.dart';
import 'package:shopscan/services/firebase/auth_services.dart';
import 'package:shopscan/services/misc/overlays.dart';
import 'package:shopscan/services/misc/toast.dart';
import 'package:shopscan/services/misc/validate.dart';
import 'package:shopscan/styles/button_styles.dart';
import 'package:shopscan/styles/input_styles.dart';
import 'package:shopscan/styles/text_styles.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // for viewing password
  bool _visible = true;

  // disabling buttons
  bool _isButtonEnabled = true;

  // custom validation text during signup
  String? _emailMsg;

  // validation
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  bool _validateSignup = false;

  // form key
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // controllers
  TextEditingController _usernameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  // form validation
  void validate() {
    setState(() {
      _autovalidate = AutovalidateMode.always;
      _validateSignup = false;
      _emailMsg = null;
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_formKey.currentState!.validate()) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();

        signUp();
      } else
        print("error");
    });
  }

  // signup if form is valid
  void signUp() async {
    setState(() {
      _isButtonEnabled = false;
      _validateSignup = true;
    });

    ShowOverlay.overlay1(context);
    var authInfo = await AuthServices.signUp(
        _emailCtrl.text, _passwordCtrl.text, _usernameCtrl.text);
    ShowOverlay.stop();

    setState(() {
      _isButtonEnabled = true;
    });
    if (authInfo['email']) {
      print("Signed Up");
      ShowToast.toast1("Account Created");
      // route to home
    Navigator.of(context).pushReplacementNamed(QrReader.routeName);
    } else {
      print("error");
      setState(() {
        _emailMsg = "User with this email exists !";
      });
    }
  }

  // sign in with google
  void googleSignIn() async {
    bool signedIn = await AuthServices.signInWithGoogle();
    if (signedIn) {
      print("Signed Up");
      ShowToast.toast1("Account Created");
      // route to home
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                SizedBox(height: 5),

                Container(
                  width: double.infinity,
                  child: Text(
                    "Create an account",
                    style: TextStyles.heading1,
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  child: Text(
                    "Sign up to see our top picks for you",
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                SizedBox(height: 80),

                // Form
                Form(
                  key: _formKey,
                  autovalidateMode: _autovalidate,
                  child: Column(
                    children: <Widget>[
                      // Username
                      Container(
                        width: double.infinity,
                        child: Text(
                          "Username",
                          style: TextStyles.label,
                        ),
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        controller: _usernameCtrl,
                        decoration: InputStyles.username,
                        cursorColor: Colors.brown,
                        keyboardType: TextInputType.name,
                        validator: Validate.username,
                      ),

                      SizedBox(height: 30),

                      // Email
                      Container(
                        width: double.infinity,
                        child: Text(
                          "Email Address",
                          style: TextStyles.label,
                        ),
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        controller: _emailCtrl,
                        decoration: InputStyles.email,
                        cursorColor: Colors.brown,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateSignup
                            ? (value) => _emailMsg
                            : Validate.email,
                      ),

                      SizedBox(height: 30),

                      // Password
                      Container(
                        width: double.infinity,
                        child: Text(
                          "Password",
                          style: TextStyles.label,
                        ),
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        controller: _passwordCtrl,
                        decoration: InputStyles.password(
                          IconButton(
                            icon: Icon(_visible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              print(_visible);
                              setState(() {
                                _visible = !_visible;
                              });
                            },
                          ),
                        ),
                        obscureText: _visible,
                        cursorColor: Colors.brown,
                        keyboardType: TextInputType.visiblePassword,
                        validator: Validate.password,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled
                        ? () {
                            validate();
                          }
                        : null,
                    child: Text(
                      "Sign Up",
                      style: TextStyles.buttontext1,
                    ),
                    style: ButtonStyles.button2,
                  ),
                ),

                SizedBox(height: 50),

                Text("Or Sign Up With"),

                SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      googleSignIn();
                    },
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/google.svg",
                          width: 25,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 7.5, 0, 7.5),
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: Colors.white, width: 0.25)),
                            ),
                            child: Center(
                              child: Text(
                                "Login with Google",
                                style: TextStyles.buttontext1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 37)
                      ],
                    ),
                    style: ButtonStyles.button3,
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
