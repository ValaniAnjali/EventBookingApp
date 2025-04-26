import 'package:bookingapp/pages/FakePaymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {
  String name, image, location, date, detail, price;
  DetailPage(
      {required this.date,
      required this.detail,
      required this.location,
      required this.price,
      required this.name,
      required this.image});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int ticket = 1;
  //to change amount according to number of ticket
  double price = 0.0;
  double totalAmount = 0.0;
  String? name, image, id;

  // ontheload()async{
  //   name=await SharedP
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    price = double.tryParse(widget.price) ?? 0.0;
    totalAmount = price * ticket;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  "images/event.jpg",
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(top: 40.0, left: 20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.black45),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(widget.date,
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            211, 255, 255, 255),
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(widget.location,
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            211, 255, 255, 255),
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("About event",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(widget.detail,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 19.0,
                      fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text("Number of Tickets",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 40.0,
                  ),
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54, width: 2.0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ticket = ticket + 1;
                            totalAmount = price * ticket;
                            setState(() {});
                          },
                          child: Text(
                            "+",
                            style:
                                TextStyle(color: Colors.black, fontSize: 25.0),
                          ),
                        ),
                        Text(
                          ticket.toString(),
                          style: TextStyle(
                              color: Color(0xff6351ec),
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (ticket > 1) {
                              ticket = ticket - 1;
                              totalAmount = price * ticket;
                              setState(() {});
                            }
                          },
                          child: Text(
                            "-",
                            style:
                                TextStyle(color: Colors.black, fontSize: 25.0),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 10.0),
              child: Row(
                children: [
                  Text(
                    "Amount : \$${totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Color(0xff6351ec),
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await FirebaseFirestore.instance
                          .collection('bookings')
                          .add({
                        'name': widget.name,
                        'image': widget.image,
                        'location': widget.location,
                        'date': widget.date,
                        'detail': widget.detail,
                        'price': widget.price,
                        'ticket': ticket,
                        'totalAmount': totalAmount,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FakePaymentScreen()),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xff6351ec),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                        child: Text(
                          "Book Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
