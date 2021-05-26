import 'package:flutter/material.dart';
import 'package:shopscan/services/firebase/auth_services.dart';
import 'package:shopscan/services/misc/overlays.dart';
import 'package:shopscan/services/misc/toast.dart';
import 'package:shopscan/services/misc/validate.dart';
import 'package:shopscan/styles/button_styles.dart';
import 'package:shopscan/styles/input_styles.dart';
import 'package:shopscan/styles/text_styles.dart';

import 'login.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/forgot_password';
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // disabling
  bool _isButtonEnabled = true;
  bool _isPasswordReset = false;

  // controllers
  TextEditingController _emailCtrl = TextEditingController();

  // custom validation text during reset
  String? _emailMsg;

  // validation
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  bool _validateReset = false;

  // form validation
  void validate() {
    setState(() {
      _autovalidate = AutovalidateMode.always;
      _validateReset = false;
      _emailMsg = null;
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_formKey.currentState!.validate()) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();

        resetPass();
      } else
        print("error");
    });
  }

  // resetpass if form is valid
  void resetPass() async {
    setState(() {
      _isButtonEnabled = false;
      _validateReset = true;
    });

    ShowOverlay.overlay1(context);
    Map authInfo = await AuthServices.resetPassword(_emailCtrl.text);
    ShowOverlay.stop();

    setState(() {
      _isButtonEnabled = true;
    });
    if (authInfo['email']) {
      print("Password Reset");
      setState(() {
        _isButtonEnabled = false;
        _isPasswordReset = true;
      });
    } else {
      print("error");
      setState(() {
        _emailMsg = "No user with this email exist !";
      });
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
                    "Next time,\nRemember your password :)",
                    style: TextStyles.heading1,
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
                        validator: _validateReset
                            ? (value) => _emailMsg
                            : Validate.email,
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
                            "Reset password",
                            style: TextStyles.buttontext1,
                          ),
                          style: ButtonStyles.button2,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                _isPasswordReset
                    ? Column(
                        children: <Widget>[
                          SizedBox(height: 60),
                          Text(
                            "A password reset link is sent to your mail",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Back to Login",
                                style: TextStyles.buttontext1,
                              ),
                              style: ButtonStyles.button3,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
