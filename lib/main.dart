import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopscan/screens/home.dart';
import 'package:shopscan/screens/login.dart';
import 'package:shopscan/screens/qr_generate.dart';
import 'package:shopscan/screens/qr_reader.dart';
import 'package:shopscan/screens/recent_visits.dart';
import 'package:shopscan/screens/your_shop.dart';
import 'package:shopscan/screens/signup.dart';
import 'screens/errorpg.dart';
import 'screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfect QR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Error
          if (snapshot.hasError) {
            return Errorpg();
          }

          // Success
          if (snapshot.connectionState == ConnectionState.done) {
            final FirebaseAuth _auth = FirebaseAuth.instance;

            return _auth.currentUser != null ? HomePage() : LogIn();
          }

          // Loading
          return Splash();
        },
      ),
      routes: {
        HomePage.routeName: (ctx) => HomePage(),
        QrReader.routeName: (ctx) => QrReader(),
        GenerateQr.routeName: (ctx) => GenerateQr(),
        SignUp.routeName: (ctx) => SignUp(),
        LogIn.routeName: (ctx) => LogIn(),
        RecentVisits.routeName: (ctx) => RecentVisits(),
        YourShop.routeName: (ctx) => YourShop(),
      },
    );
  }
}
