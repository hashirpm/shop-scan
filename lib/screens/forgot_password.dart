import 'package:firebase_auth/firebase_auth.dart';
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
  static FirebaseAuth _auth = FirebaseAuth.instance;
  // controllers
  TextEditingController _emailCtrl = TextEditingController();

  String? _emailMsg;

  // validation
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  bool _validateLogin = false;
  void validate() {
    setState(() {
      _autovalidate = AutovalidateMode.always;
      _validateLogin = false;
      _emailMsg = null;
    });
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    );
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: 'samplePwd',
      );
      ShowToast.toast1("Check your email");
    } catch (e) {
      ShowToast.toast1("This email is not registered with us!");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          elevation: 0,
          toolbarHeight: 80,
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
              child: Column(children: <Widget>[
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
                  child: Column(children: <Widget>[
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
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          resetPassword(_emailCtrl.text);

                          // route to home
                          Navigator.of(context)
                              .pushReplacementNamed(LogIn.routeName);
                        },
                        child: Text(
                          "Send Email",
                          style: TextStyles.buttontext1,
                        ),
                        style: ButtonStyles.button2,
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          ),
        ));
  }
}
