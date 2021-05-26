import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopscan/services/firebase/firestore_services.dart';

class LatestVisit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreServices.getYourLastVisit(),
      builder: (context, snapshot) {
        // Error
        if (snapshot.hasError) {
          return Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child: Center(
              child: Text(
                "Network Error!",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }

        // Success
        if (snapshot.connectionState == ConnectionState.done) {
          Map? data = snapshot.data as Map?;

          if (data != null) {
            return Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                    child: Text(
                      'Last visit: ',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                          child: Text(
                            data['name'],
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Ph no: ${data['phone'].toString()}',
                          style: GoogleFonts.poppins(),
                        ),
                        Text(
                          'Pin code: ${data['pin'].toString()}',
                          style: GoogleFonts.poppins(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              child: Center(
                child: Text(
                  "Scan your first QR 😇",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }
        }

        // Loading
        return Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Center(
            child: SpinKitRing(
              color: Colors.black38,
              lineWidth: 4,
            ),
          ),
        );
      },
    );
  }
}
