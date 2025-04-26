import 'package:bookingapp/pages/detail_page.dart';
import 'package:bookingapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream? eventStream;

  ontheload() async {
    eventStream = await DatabaseMethods().getAllEvents();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allEvents() {
    return StreamBuilder(
        stream: eventStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      date: ds["Date"],
                                      detail: ds["Detail"],
                                      location: ds["Location"],
                                      price: ds["Price"],
                                      name: ds["Name"],
                                      image: ds["Image"])));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      "images/event.jpg",
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10.0, top: 10.0),
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        ds["Date"], // You can replace with ds['date'] or ds['eventDate']
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ds['Name'] ??
                                      "Event Title", // Replace with Firestore field
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text(
                                    "\$${ds['Price'] ?? '0'}", // Replace with Firestore field
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xff6351ec),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on),
                                Text(
                                  ds['Location'] ??
                                      "Unknown Location", // Replace with Firestore field
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 50.0, left: 20.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffe3e6ff), Color(0xfff1f3ff), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                    ),
                    Text(
                      "Events Are here....",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Hello Anjali",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "There are 20 events \n near your location",
                  style: TextStyle(
                      color: Color(0xff6351ec),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  padding: EdgeInsets.only(left: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search_outlined),
                        border: InputBorder.none,
                        hintText: "Search an Event.."),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        child: Material(
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 130,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/music.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  Text(
                                    "Music",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        child: Material(
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 130,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/clothing.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  Text(
                                    "Clothing",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        child: Material(
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 130,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/music.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  Text(
                                    "Festival",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        child: Material(
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 130,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/music.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  Text(
                                    "music",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Upcoming Events",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text("See All",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                allEvents(),
                // Container(
                //   margin: EdgeInsets.only(right: 20.0),
                //   width: MediaQuery.of(context).size.width,
                //   decoration: BoxDecoration(),
                //   child: Stack(
                //     children: [
                //       ClipRRect(
                //         borderRadius: BorderRadius.circular(10),
                //         child: Image.asset(
                //           "images/event.jpg",
                //           height: 200,
                //           width: MediaQuery.of(context).size.width,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //       Container(
                //         margin: EdgeInsets.only(left: 10.0, top: 10.0),
                //         width: 50.0,
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(10)),
                //         child: Center(
                //           child: Text(
                //             "Aug\n24",
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //                 color: Colors.black,
                //                 fontSize: 16.0,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 5.0,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Dua lipa concert",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 16.0,
                //           fontWeight: FontWeight.bold),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(right: 20.0),
                //       child: Text(
                //         "\$50",
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //             color: Color(0xff6351ec),
                //             fontSize: 16.0,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Icon(Icons.location_on),
                //     Text(
                //       "Mumbai,India",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 22.0,
                //           fontWeight: FontWeight.w500),
                //     ),
                //   ],
                // )
              ],
            ),
          )),
    );
  }
}
