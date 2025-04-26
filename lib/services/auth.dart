import 'package:bookingapp/pages/bottomnav.dart';
import 'package:bookingapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await auth.currentUser;
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
      accessToken: googleSignInAuthentication?.accessToken,
    );

    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;

    if (result != null) {
      // Save user info in the database (already implemented)
      Map<String, dynamic> userInfoMap = {
        "Name": userDetails!.displayName,
        "Image": userDetails.photoURL,
        "Email": userDetails.email,
        "Id": userDetails.uid
      };
      await DatabaseMethods().addUserDetail(userInfoMap, userDetails.uid);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Registered Successfully..",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ));

      // Redirect to BottomNav page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Bottomnav()),
      );
    }
  }
}
