import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<Map<String, dynamic>> userDataFuture;

  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return {
          'name': userDoc['Name'],
          'email': userDoc['Email'],
          'imageUrl': userDoc['Image'],
        };
      } else {
        throw Exception('User document does not exist');
      }
    } else {
      throw Exception('No user logged in');
    }
  }

  @override
  void initState() {
    super.initState();
    userDataFuture = fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is loading
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there was an error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // When data is ready
            final userData = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  userData['imageUrl'].isNotEmpty
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(userData['imageUrl']),
                        )
                      : const CircleAvatar(
                          radius: 60,
                          child: Icon(Icons.person, size: 50),
                        ),
                  const SizedBox(height: 20),
                  Text(
                    userData['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userData['email'],
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }
}
