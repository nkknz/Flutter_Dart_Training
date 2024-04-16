import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  //create instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  //Future because we want it to be async
  //whole function return type changes to future
  Future<String> signUpUser({
    //accepts multiple arguments
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      //check validation for the arguments
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);
        //checking id the StorageMethods work - adding of picture to the database
        //isPost is false because we are returning a profile picture, profilePics is the name of the folder
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        //add user to the database
        //.collection create collection 'users' if it doesnt exist
        //.doc create document 'user' if it doesnt exist
        //and set the data inside the .doc()
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

        //another way of doing it
        //generates random UID
        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res = "Succes";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
