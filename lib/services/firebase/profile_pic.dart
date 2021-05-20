import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfilePic {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static String? getImgUrl() {
    return _auth.currentUser!.photoURL;
  }
}
