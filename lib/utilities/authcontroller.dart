// ignore_for_file: unnecessary_import, prefer_const_constructors
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greenify_new/screens/landing_page.dart';
import 'package:greenify_new/screens/loginpage.dart';
import 'package:greenify_new/utilities/storagemethod.dart';
import 'package:greenify_new/utilities/user.dart' as model;

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? _user) {
    if (_user == null) {
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => Home());
    }
  }

  Future<model.User> getUserDetails() async {
    User currentuser = auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentuser.uid).get();
    return model.User.fromSnap(snap);
  }

  // SignUp User
  Future<String> register(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    var res = "Some Error Occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          email.isEmail &&
          password.length >= 6) {
        // Register User
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        res = "Success";
        // Upload Image in Firestore Storage
        String imgurl =
            await StorageMethod().uploadtostorage('profilepic', file, false);

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          photourl: imgurl,
          bio: bio,
          postCount: 0,
        );
        // Adding Details in Database
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // LoginUser
  Future<String> login(
      {required String email, required String password}) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty && password.length >= 6) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = "Success";
      } else {
        res = "Please Input Valid Credentials";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // LogoutUser
  void logout() async {
    await auth.signOut();
  }
}
