import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GenerateQr extends StatelessWidget {
  static const routeName = '/generate-qr';
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PrettyQr(
          typeNumber: 3,
          size: 300,
          data: uid,
          errorCorrectLevel: QrErrorCorrectLevel.M,
          roundEdges: true,
        ),
      ),
    );
  }
}
