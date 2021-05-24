import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vibration/vibration.dart';
import 'package:intl/intl.dart';
import 'package:shopscan/services/firebase/storage_services.dart';
import 'package:shopscan/services/misc/filter_data.dart';
import 'package:shopscan/services/misc/overlays.dart';
import 'package:shopscan/services/misc/toast.dart';

abstract class FirestoreServices {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;

// COMMENTED getProductData FUNCTION
  // static Future<List> getProductData(String filter, String category) async {
  //   try {
  //     CollectionReference products = _firestore.collection('Products');

  //     DocumentSnapshot snapshot =
  //         await products.doc(category.toLowerCase()).get();

  //     Map? dataMap = snapshot.data() as Map?;
  //     List data = [];

  //     dataMap!.forEach((key, value) => data.add(value));

  //     // filter data
  //     if (filter == "New")
  //       data = FilterData.latest(data);
  //     else if (filter == "Popular")
  //       data = FilterData.popular(data);
  //     else if (filter == "Sale") data = FilterData.sale(data);

  //     return data;
  //   } catch (e) {
  //     print(e);
  //     return [];
  //   }
  // }

  static Future createUser(
    String username,
    String phone,
    String pin,
    bool? vaccinated,
  ) async {
    try {
      CollectionReference users = _firestore.collection('Users');
      await users.doc(_auth.currentUser!.uid).set({
        'name': username,
        'phone': int.parse(phone),
        'pin': int.parse(pin),
        'vaccinated': vaccinated
      });
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  static Future<Map?> getUserData() async {
    try {
      CollectionReference users = _firestore.collection('Users');
      DocumentSnapshot snapshot = await users.doc(_auth.currentUser!.uid).get();

      Map? data = snapshot.data() as Map?;
      if (data != null)
        data['displayName'] = _auth.currentUser!.displayName;
      else
        data = {'displayName': _auth.currentUser!.displayName};

      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future onScan(String scanUid) async {
    try {
      CollectionReference users = _firestore.collection('Users');
      await users.doc(_auth.currentUser!.uid).collection('YouVisited').add({
        'uid': scanUid,
        'time': DateFormat('yMMMMd').format(DateTime.now())
      });
      await users.doc(scanUid).collection('VisitedYou').add({
        'uid': _auth.currentUser!.uid,
        'time': DateFormat('yMMMMd').format(DateTime.now())
      });
      ShowToast.toast1("Added to your recent visits");
      Vibration.vibrate(amplitude: 255);
    } catch (e) {
      print(e);
      return null;
    }
  }

//COMMENTED updateProfile FUNCTION
  // static Future<bool> updateProfile(
  //     File image, String name, String address, String city, String code) async {
  //   try {
  //     CollectionReference users = _firestore.collection('Users');
  //     Map? userData = await getUserData();
  //     Map imgData;

  //     if (image != null) {
  //       if (userData != null && userData['imgUrl'] != null) {
  //         // delete img
  //         await StorageServices.deleteImg(userData['filename']);
  //       }

  //       // upload img get url
  //       imgData = await StorageServices.uploadImg(image);

  //       // update user profile
  //       await _auth.currentUser!.updateProfile(photoURL: imgData['imgUrl']);
  //       await _auth.currentUser!.updateProfile(displayName: name);

  //       // set new data
  //       await users.doc(_auth.currentUser!.uid).set({
  //         'name': name,
  //         'address': address,
  //         'city': city,
  //         'code': code,
  //         'imgUrl': imgData['imgUrl'],
  //         'filename': imgData['filename']
  //       });
  //     } else {
  //       // update user profile
  //       await _auth.currentUser!.updateProfile(displayName: name);

  //       // if user update data else create user
  //       if (userData!['name'] != null) {
  //         await users.doc(_auth.currentUser!.uid).update({
  //           'name': name,
  //           'address': address,
  //           'city': city,
  //           'code': code,
  //         });
  //       } else
  //         await users.doc(_auth.currentUser!.uid).set({
  //           'name': name,
  //           'address': address,
  //           'city': city,
  //           'code': code,
  //         });
  //     }

  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

}
