import 'package:event_booking/Pages/bottomnav.dart';
import 'package:event_booking/services/database.dart';
import 'package:event_booking/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User? userDetails = result.user;
    await SharedPreferenceHelper.saveUserId(userDetails!.uid);
    await SharedPreferenceHelper.saveUserName(userDetails.displayName ?? "");
    await SharedPreferenceHelper.saveUserEmail(userDetails.email ?? "");
    await SharedPreferenceHelper.saveUserImage(userDetails.photoURL ?? "");
    await SharedPreferenceHelper.saveIsLoggedIn(true);

    Map<String, dynamic> userData = {
      "Name": userDetails.displayName,
      "Email": userDetails.email,
      "Image": userDetails.photoURL,
      "Id": userDetails.uid,
    };

    await DatabaseMethods()
        .addUserDetail(userData, userDetails.uid)
        .then((value) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Registered Sucessfully!",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          )));
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context, MaterialPageRoute(builder: (context) => BottomNav(
            userId: userDetails.uid,
          )));
    });
  }

  Future<void> signOut(BuildContext context) async {
    await auth.signOut();
    await SharedPreferenceHelper.clearUserData(); 
  }
}
