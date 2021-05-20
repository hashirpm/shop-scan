import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future logIn(String email, String password) async {
    var authInfo = {"email": true, "password": true};
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return authInfo;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        authInfo['email'] = false;
        return authInfo;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        authInfo['password'] = false;
        return authInfo;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future signUp(String email, String password, String username) async {
    var authInfo = {"email": true};
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser!.updateProfile(displayName: username);
      return authInfo;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        authInfo['email'] = false;
        return authInfo;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> signInWithGoogle() async {
    try {
      
      final googleUser = await _googleSignIn.signIn();
    
     
      var authentication = googleUser!.authentication;
            final googleAuth = await authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print(credential);
      await _auth.signInWithCredential(credential);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
