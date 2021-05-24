import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shopscan/screens/login.dart';
import 'package:shopscan/screens/qr_generate.dart';
import 'package:shopscan/screens/recent_visits.dart';
import 'package:shopscan/screens/your_shop.dart';
import 'package:shopscan/services/firebase/auth_services.dart';
import 'package:shopscan/services/firebase/firestore_services.dart';
import 'package:shopscan/styles/button_styles.dart';
import 'package:shopscan/styles/colours.dart';

class QrReader extends StatefulWidget {
  static const routeName = '/qr-reader';
  @override
  _QrReaderState createState() => _QrReaderState();
}

class _QrReaderState extends State<QrReader> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan the Code"),
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 80,
        leading: TextButton(
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 23,
            child: Icon(Icons.login, color: Colors.black),
          ),
          onPressed: () async {
            await AuthServices.signOut();
            Navigator.of(context).pushReplacementNamed(LogIn.routeName);
            setState(() {});
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 5, child: _buildQrView(context)),
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  result != null
                      ? Text('Data: ${result!.code}')
                      : Text('Scan a code!'),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                var icon = (snapshot.data == false)
                                    ? Icon(Icons.flash_off)
                                    : Icon(Icons.flash_on);
                                return CircleAvatar(
                                  child: icon,
                                );
                                // return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: TextButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                var icon = (snapshot.data == CameraFacing.back)
                                    ? Icon(Icons.camera_front)
                                    : Icon(Icons.camera_rear);
                                return CircleAvatar(
                                  child: icon,
                                );
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //   margin: EdgeInsets.all(8),
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       await controller?.pauseCamera();
                      //     },
                      //     child: Text('pause', style: TextStyle(fontSize: 20)),
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.all(8),
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       await controller?.resumeCamera();
                      //     },
                      //     child: Text('resume', style: TextStyle(fontSize: 20)),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context)
                                .pushNamed(GenerateQr.routeName);
                          },
                          child: Text('Generate QR',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      endDrawer: Drawer(
        elevation: 16,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(16.0),
              child: CircleAvatar(
                backgroundColor: Colors.black,
              ),
            ),
            Text(
              FirebaseAuth.instance.currentUser!.displayName!,
              style: TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(
              thickness: 3,
            ),
            TextButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(RecentVisits.routeName);
              },
              child: Text("Your Recent Visits"),
              style: TextButton.styleFrom(
                  primary: Colors.white, backgroundColor: Colors.blue[600]),
              // options: FFButtonOptions(
              //   width: double.infinity,
              //   height: 40,
              //   color: FlutterFlowTheme.primaryColor,
              //   textStyle: FlutterFlowTheme.subtitle2.override(
              //     fontFamily: 'Poppins',
              //     color: Colors.white,
              //   ),
              //   borderSide: BorderSide(
              //     color: Colors.transparent,
              //     width: 1,
              //   ),
              //   borderRadius: 0,
              // ),
            ),
            TextButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(YourShop.routeName);
              },
              child: Text("Your Shop"),
              style: TextButton.styleFrom(
                  primary: Colors.white, backgroundColor: Colors.blue[600]),
              // options: FFButtonOptions(
              //   width: double.infinity,
              //   height: 40,
              //   color: FlutterFlowTheme.primaryColor,
              //   textStyle: FlutterFlowTheme.subtitle2.override(
              //     fontFamily: 'Poppins',
              //     color: Colors.white,
              //   ),
              //   borderSide: BorderSide(
              //     color: Colors.transparent,
              //     width: 1,
              //   ),
              //   borderRadius: 0,
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    // ignore: cancel_subscriptions
    StreamSubscription? scanListener;
    scanListener = controller.scannedDataStream.listen((scanData) {
      FirestoreServices.onScan(scanData.code);
      scanListener!.cancel();
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
