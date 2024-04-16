import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // get the uid
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding image to firebase storage

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    //ref method a pointer to the file in the storage
    ///.ref() a reference to a file that exists or does not exist
    //.path() a folder that exist or does not exist
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    //UploadTask ability to control how the file is being uploaded to the firebase storage
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    //get the download url which will save in the firestore data base
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
