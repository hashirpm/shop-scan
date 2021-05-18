import 'package:flutter/material.dart';
import 'package:shopscan/screens/qr_generate.dart';
import 'package:shopscan/screens/qr_reader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfect QR',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: QrReader(),
      routes: {
GenerateQr.routeName:(ctx)=>GenerateQr(),
      },
    );
  }
}


