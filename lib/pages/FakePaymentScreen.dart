import 'package:bookingapp/pages/PaymentSuccessScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class FakePaymentScreen extends StatefulWidget {
  const FakePaymentScreen({super.key});

  @override
  State<FakePaymentScreen> createState() => _FakePaymentScreenState();
}

class _FakePaymentScreenState extends State<FakePaymentScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate 3 seconds payment processing
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PaymentSuccessScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Processing Payment...',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
