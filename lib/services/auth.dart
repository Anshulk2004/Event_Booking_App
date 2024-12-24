import 'package:event_booking/Pages/bottomnav.dart';
import 'package:event_booking/services/database.dart';
import 'package:event_booking/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final String adminEmail = "anshulk0102@gmail.com";

  getCurrentUser() async {
    return auth.currentUser;
  }

  bool isUserAdmin(String email) {
    return email == adminEmail;
  }

  Future<void> handleSignIn(UserCredential userCredential) async {
    final user = userCredential.user;
    if (user != null) {
      bool isAdmin = user.email == adminEmail;
      await SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('isAdmin', isAdmin);
      });
    }
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        // User canceled the sign-in process
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result =
          await firebaseAuth.signInWithCredential(credential);

      User? userDetails = result.user;

      if (userDetails != null) {
        bool isAdmin = isUserAdmin(userDetails.email ?? "");           
      await SharedPreferenceHelper.saveIsAdmin(isAdmin); 
      await SharedPreferenceHelper.saveUserId(userDetails.uid);
      await SharedPreferenceHelper.saveUserName(userDetails.displayName ?? "");
      await SharedPreferenceHelper.saveUserEmail(userDetails.email ?? "");
      await SharedPreferenceHelper.saveUserImage(userDetails.photoURL ?? "");
      await SharedPreferenceHelper.saveIsLoggedIn(true);

        Map<String, dynamic> userData = {
          "Name": userDetails.displayName,
          "Email": userDetails.email,
          "Image": userDetails.photoURL,
          "isAdmin": isAdmin,
          "Id": userDetails.uid,
          "createdAt": DateTime.now().toString(),
        };

        await DatabaseMethods()
            .addUserDetail(userData, userDetails.uid)
            .then((value) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                isAdmin ? "Welcome Admin!" : "Registered Successfully!",
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),                              
              ),
              duration: const Duration(seconds: 2),
              ));
          Navigator.pushReplacement(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNav(
                        userId: userDetails.uid,
                      )));
        });
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Error signing in: ${e.toString()}",
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          )));
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
      await SharedPreferenceHelper.clearUserData();

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signed out successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing out: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
