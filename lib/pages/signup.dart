import 'package:bookingapp/admin/uploadevent.dart';
import 'package:bookingapp/services/auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Image.asset(
              "images/orange.png",
              height: 400,
              width: MediaQuery.of(context).size.width,

              // fit: ,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Unlock the Future of",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Event Booking System",
              style: TextStyle(
                  color: Color(0xff6351ec),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Discover, book , and experience unforgettable moment effortlessly!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                AuthMethods().signInWithGoogle(context);
              },
              child: Container(
                height: 70,
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                decoration: BoxDecoration(
                    color: Color(0xff6351ec),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/google.jpg",
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Sign in with Google",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  //note: here further i can improve for safety like first redirect to admin login check credential than redirect to this page.
                  MaterialPageRoute(builder: (context) => UploadEvent()),
                );
              },
              child: Text(
                "Are you admin?",
                style: TextStyle(
                  color: Color(0xff6351ec),
                  fontSize: 18.0,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
