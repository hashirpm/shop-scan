import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class GenerateQr extends StatelessWidget {
  static const routeName = '/generate-qr';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
         PrettyQr(

            typeNumber: 3,
            size: 300,
            data: 'https://www.google.com',
            errorCorrectLevel: QrErrorCorrectLevel.M,
            roundEdges: true),
      ),
    );
  }
}
