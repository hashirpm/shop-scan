import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageServices {
  static FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<Map> uploadImg(File image) async {
    String path = image.path;
    String filename = DateTime.now().toIso8601String() + path.split("/").last;
    Reference imgRef = _storage.ref('profilepics/' + filename);

    try {
      await imgRef.putFile(image);
      String imgUrl = await imgRef.getDownloadURL();
      print("uploaded");
      return {'filename': filename, 'imgUrl': imgUrl};
    } catch (e) {
      print(e);
      return {};
    }
  }

  static Future deleteImg(String filename) async {
    Reference imgRef = _storage.ref('profilepics/' + filename);

    try {
      await imgRef.delete();
      print("deleted");
    } catch (e) {
      print(e);
    }
  }
}
