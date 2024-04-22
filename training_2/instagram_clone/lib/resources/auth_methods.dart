import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/models/user.dart'
    as model; //put as model so we know if it is a model

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
        //add Model
        model.User user = model.User(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );
        //.collection create collection 'users' if it doesnt exist
        //.doc create document 'user' if it doesnt exist
        //and set the data inside the .doc()
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

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

        res = "Success";
      }
    } on FirebaseAuthException catch (err) {
      //catch error or exceptions
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted.';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //logging in user

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
