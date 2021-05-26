import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopscan/components/calendar.dart';
import 'package:shopscan/components/latest_visit.dart';
import 'package:shopscan/screens/login.dart';
import 'package:shopscan/screens/qr_generate.dart';
import 'package:shopscan/screens/qr_reader.dart';
import 'package:shopscan/screens/recent_visits.dart';
import 'package:shopscan/screens/your_shop.dart';
import 'package:shopscan/services/firebase/auth_services.dart';
import 'package:shopscan/styles/button_styles.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void refresh(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF795548),
        title: Text(
          'Shop Scan',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      drawer: Drawer(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RecentVisits.routeName);
                },
                child: Text(
                  "Your Recent Visits",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                style: ButtonStyles.button2brown,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(YourShop.routeName);
                },
                child: Text(
                  "Your Shop",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                style: ButtonStyles.button2brown,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  await AuthServices.signOut();
                  await Navigator.of(context)
                      .pushReplacementNamed(LogIn.routeName);
                },
                child: Text(
                  "Logout",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                style: ButtonStyles.button2brown,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(QrReader.routeName)
                                .then(refresh);
                          },
                          child: Text(
                            'Scan a QR',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                          style: ButtonStyles.button2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(GenerateQr.routeName)
                                .then(refresh);
                          },
                          child: Text(
                            'Show my QR',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                          style: ButtonStyles.button2,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color(0xFFF5F5F5),
                    elevation: 10,
                    child: LatestVisit(),
                  ),
                ),
                Container(
                  child: Calendar(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
