import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:bookingapp/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';

class UploadEvent extends StatefulWidget {
  const UploadEvent({super.key});

  @override
  State<UploadEvent> createState() => _UploadEventState();
}

class _UploadEventState extends State<UploadEvent> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController detailController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();

  final List<String> eventCategory = ["Music", "Food", "Clothing", "Festival"];
  String? value;
  final ImagePicker _picker = ImagePicker();
  io.File? SelectedImageFile;
  Uint8List? SelectedImageBytes;
  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    if (kIsWeb) {
      // For Web
      SelectedImageBytes = await image.readAsBytes();
    } else {
      SelectedImageFile = io.File(image.path);
    }
    SelectedImageFile = io.File(image.path);
    setState(() {});
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 10, minute: 00);

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    // Convert TimeOfDay to DateTime
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    // Format to desired format with leading zero
    return DateFormat('hh:mm a').format(dateTime);
  }

  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: 40.0,
          left: 20.0,
          right: 20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5.0,
                  ),
                  Text(
                    "Upload Event",
                    style: TextStyle(
                        color: Color(0xff6351ec),
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),

////here i changed code so that it works for web too
              const SizedBox(height: 20.0),
              Center(
                child: (kIsWeb && SelectedImageBytes != null)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          SelectedImageBytes!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    : (!kIsWeb && SelectedImageFile != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              SelectedImageFile!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : GestureDetector(
                            onTap: getImage,
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black45, width: 2.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(Icons.camera_alt_outlined),
                            ),
                          ),
              ),

              SizedBox(
                height: 20.0,
              ),
              Text(
                "Event name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Enter Event Name"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Ticket Price",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Enter Price"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Event Location",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Enter Location"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Select Category",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: eventCategory
                        .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                            )))
                        .toList(),
                    onChanged: ((value) => setState(() {
                          this.value = value;
                        })),
                    dropdownColor: Colors.white,
                    hint: Text("Select Category"),
                    iconSize: 36,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    /////////most imp line to get value that we selected else how we get update right??
                    value: value,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _pickDate();
                    },
                    child: Icon(
                      Icons.calendar_month,
                      color: Colors.blue,
                      size: 30.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd').format(selectedDate),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ), // TextStyle
                  ), // Text
                  SizedBox(
                    width: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      _pickTime();
                    },
                    child: Icon(
                      Icons.alarm,
                      color: Colors.blue,
                      size: 30.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    formatTimeOfDay(selectedTime),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ), // TextStyle
                  ), // Text
                ], // Row
              ), // Row
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Event Detail",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: detailController,
                  maxLines: 6,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "what will be on that event..??"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () async {
                  //whichever is commented code that are used for upload image in firebase storage which is premium if you buy and want to upload image there just uncomment this code .
                  // String addId = randomAlphaNumeric(10);
                  // Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("blogImages").child(addId);
                  // final UploadTask task = firebaseStorageRef.putFile(SelectedImage!);
                  // var downloadUrl=await(await task).ref.getDownloadURL();
                  String id = randomAlphaNumeric(10);
                  Map<String, dynamic> uploadEvent = {
                    // "Image":downloadUrl,
                    "Image": "",
                    "Name": nameController.text,
                    "Price": priceController.text,
                    "Category": value,
                    "Detail": detailController.text,
                    "Date": DateFormat('yyyy-MM-dd').format(selectedDate!),
                    "Time": formatTimeOfDay(selectedTime),
                    "Location": locationController.text,
                  };
                  await DatabaseMethods()
                      .addEvent(uploadEvent, id)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          "Event has been uploaded Successfully..",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )));
                  });
                  setState(() {
                    nameController.text = "";
                    priceController.text = "";
                    detailController.text = "";
                    locationController.text = "";
                    SelectedImageBytes = null;
                    SelectedImageFile = null;
                  });
                },
                child: Center(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xff6351ec),
                        borderRadius: BorderRadius.circular(10)),
                    width: 200,
                    child: Center(
                      child: Text(
                        "Upload",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
