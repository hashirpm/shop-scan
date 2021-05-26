import 'package:flutter/material.dart';
import 'package:shopscan/screens/home.dart';
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
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();
  TextEditingController _phnoCtrl = TextEditingController();
  TextEditingController _pincodeCtrl = TextEditingController();
  bool? _isVaccinated = false;

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
        _emailCtrl.text,
        _passwordCtrl.text,
        _nameCtrl.text,
        _phnoCtrl.text,
        _pincodeCtrl.text,
        _isVaccinated);
    ShowOverlay.stop();

    setState(() {
      _isButtonEnabled = true;
    });
    if (authInfo['email']) {
      print("Signed Up");
      ShowToast.toast1("Account Created");
      // route to home
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
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
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                    "Sign up to join our network",
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
                      // Name
                      Container(
                        width: double.infinity,
                        child: Text(
                          "Name",
                          style: TextStyles.label,
                        ),
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        controller: _nameCtrl,
                        decoration: InputStyles.profileFields("Name"),
                        cursorColor: Colors.brown,
                        keyboardType: TextInputType.name,
                        validator: Validate.name,
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

                      SizedBox(height: 30),

                      Container(
                        width: double.infinity,
                        child: Text(
                          "Phone number",
                          style: TextStyles.label,
                        ),
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        controller: _phnoCtrl,
                        decoration: InputStyles.profileFields("Phone no"),
                        cursorColor: Colors.brown,
                        keyboardType: TextInputType.phone,
                        validator: Validate.phone,
                      ),

                      SizedBox(height: 30),

                      Container(
                        width: double.infinity,
                        child: Text(
                          "Pin code",
                          style: TextStyles.label,
                        ),
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        controller: _pincodeCtrl,
                        decoration: InputStyles.profileFields("Pin code"),
                        cursorColor: Colors.brown,
                        keyboardType: TextInputType.number,
                        validator: Validate.pin,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  children: <Widget>[
                    Text(
                      "Vaccinated?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        value: _isVaccinated,
                        // shape: CircleBorder(),
                        checkColor: Colors.brown,
                        activeColor: Colors.white,
                        onChanged: (bool? value) {
                          setState(() {
                            _isVaccinated = value;
                          });
                        },
                      ),
                    ),
                  ],
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

                SizedBox(height: 10),

                // Text("Or Sign Up With"),

                // SizedBox(height: 20),

                // Container(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       googleSignIn();
                //     },
                //     child: Row(
                //       children: <Widget>[
                //         SvgPicture.asset(
                //           "assets/icons/google.svg",
                //           width: 25,
                //         ),
                //         SizedBox(width: 12),
                //         Expanded(
                //           child: Container(
                //             padding: EdgeInsets.fromLTRB(0, 7.5, 0, 7.5),
                //             decoration: BoxDecoration(
                //               border: Border(
                //                   left: BorderSide(
                //                       color: Colors.white, width: 0.25)),
                //             ),
                //             child: Center(
                //               child: Text(
                //                 "Login with Google",
                //                 style: TextStyles.buttontext1,
                //               ),
                //             ),
                //           ),
                //         ),
                //         SizedBox(width: 37)
                //       ],
                //     ),
                //     style: ButtonStyles.button3,
                //   ),
                // ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
