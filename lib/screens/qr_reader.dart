import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shopscan/screens/qr_generate.dart';
import 'package:shopscan/services/firebase/firestore_services.dart';

class QrReader extends StatefulWidget {
  static const routeName = '/qr-reader';
  @override
  _QrReaderState createState() => _QrReaderState();
}

class _QrReaderState extends State<QrReader> {
  String result = "Scan a code!";
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // ignore: cancel_subscriptions
  StreamSubscription? scanListener;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void onScan(String uid) async {
    Map? user = await FirestoreServices.getUserData(uid);
    if (user != null) {
      scanListener!.cancel();
      setState(() {
        result = user['name'];
      });
      await FirestoreServices.onScan(uid);
      Future.delayed(
        Duration(seconds: 1),
        () {
          Navigator.pop(context);
        },
      );
    } else {
      setState(() {
        result = "Invalid QR. Try again";
      });
      scanListener!.resume();
      Future.delayed(
        Duration(seconds: 2),
        () {
          setState(() {
            result = "Scan a code!";
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 80,
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
                  Text(result),
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
                          child: Text(
                            'View your QR',
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
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

    scanListener = controller.scannedDataStream.listen((scanData) {
      scanListener!.pause();
      onScan(scanData.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
