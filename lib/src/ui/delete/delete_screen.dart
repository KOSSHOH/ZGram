import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/src/app_theme.dart';

class DeleteScreen extends StatefulWidget {
  @override
  DeleteScreenState createState() => DeleteScreenState();
}

class DeleteScreenState extends State<DeleteScreen> {
  String image;

  chooseImage() {
    // ignore: deprecated_member_use
    ImagePicker.pickImage(source: ImageSource.gallery).then((value) => {
          setState(() {
            image = value.path;
          }),
        });
  }

  Widget showImageTwo(String image) {
    var file = Io.File(image);
    return Image.file(
      file,
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: ListView(
          children: <Widget>[
            OutlineButton(
              onPressed: chooseImage,
              child: Text('Choose Image'),
            ),
            SizedBox(
              height: 20.0,
            ),
            image != null ? showImageTwo(image) : Container(),
          ],
        ),
      ),
    );
  }
}
