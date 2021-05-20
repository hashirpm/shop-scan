import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopscan/screens/qr_reader.dart';
import 'package:shopscan/services/firebase/auth_services.dart';
import 'package:shopscan/services/misc/overlays.dart';
import 'package:shopscan/services/misc/validate.dart';
import 'package:shopscan/services/misc/toast.dart';
import 'package:shopscan/styles/button_styles.dart';
import 'package:shopscan/styles/input_styles.dart';
import 'package:shopscan/styles/text_styles.dart';

class LogIn extends StatefulWidget {
  static const routeName= '/login';
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // for viewing password
  bool _visible = true;

  // disabling buttons
  bool _isButtonEnabled = true;

  // custom validation text during login
  String? _emailMsg;
  String? _passwordMsg;

  // validation
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  bool _validateLogin = false;

  // form key
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // controllers
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  set currentFocus(FocusScopeNode currentFocus) {}

  // form validation
  void validate() {
    setState(() {
      _autovalidate = AutovalidateMode.always;
      _validateLogin = false;
      _emailMsg = null;
      _passwordMsg = null;
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_formKey.currentState!.validate()) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();

        logIn();
      } else
        print("error");
    });
  }

  // login if form is valid
  void logIn() async {
    setState(() {
      _isButtonEnabled = false;
      _validateLogin = true;
    });

    ShowOverlay.overlay1(context);
    var authInfo =
        await AuthServices.logIn(_emailCtrl.text, _passwordCtrl.text);
    ShowOverlay.stop();

    setState(() {
      _isButtonEnabled = true;
    });
    if (authInfo['email'] && authInfo['password']) {
      print("Logged in");
      ShowToast.toast1("Logged In");
      // route to home
      Navigator.of(context).pushReplacementNamed(QrReader.routeName);
    } else {
      print("error");

      if (!authInfo['email'])
        setState(() {
          _emailMsg = "No user with this email !";
        });
      else
        setState(() {
          _passwordMsg = "Wrong password !";
        });
    }
  }

  // sign in with google
  void googleSignIn() async {
    bool signedIn = await AuthServices.signInWithGoogle();
    print(signedIn);
    if (signedIn) {
      print("Logged in");
      ShowToast.toast1("Logged In");
      // route to home
      Navigator.of(context).pushReplacementNamed(QrReader.routeName);
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
                    "Welcome Back",
                    style: TextStyles.heading1,
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  child: Text(
                    "Login to see our top picks for you",
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
                        validator: _validateLogin
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
                        validator: _validateLogin
                            ? (value) => _passwordMsg
                            : Validate.password,
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
                      "Login",
                      style: TextStyles.buttontext1,
                    ),
                    style: ButtonStyles.button2,
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),

                SizedBox(height: 50),

                Text("Or Login With"),

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

                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("No account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                      child: Text(
                        "Create one",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
