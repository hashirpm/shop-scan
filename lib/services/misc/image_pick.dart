import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImgPick {
  static ImagePicker _picker = ImagePicker();
   static File? image;

  static Future<File> _imgFromCamera() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    final File file = File(pickedFile!.path);

    return file;
  }

  static Future<File> _imgFromGallery() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    final File file = File(pickedFile!.path);

    return file;
  }

  static void showPicker(BuildContext context, Function changePic) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Gallery'),
                    onTap: () async {
                      image = await _imgFromGallery();
                      changePic(image);
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async {
                      image = await _imgFromCamera();
                      changePic(image);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
