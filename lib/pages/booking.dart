import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Bookings")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text("Error loading data"));
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final bookings = snapshot.data!.docs;

          if (bookings.isEmpty) return Center(child: Text("No bookings yet."));

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  // leading: Image.asset(booking['image'],
                  // width: 60, fit: BoxFit.cover),
                  title: Text(booking['name']),
                  subtitle: Text(
                      "Date: ${booking['date']}\nTickets: ${booking['ticket']}\nTotal: \$${booking['totalAmount']}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
