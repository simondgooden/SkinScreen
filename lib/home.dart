import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
//import 'package:flutter_app/camera.dart';
import 'package:flutter_app/navigation_bar.dart';
import 'package:flutter_app/navigation_model.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'diagnosis.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<NavModel> items = [];
  File? image;

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(
        page: const TabPage(tab: 1),
        navKey: homeNavKey,
      ),
      NavModel(
        page: const TabPage(tab: 2),
        navKey: profileNavKey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
          items[selectedTab].navKey.currentState?.pop();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: selectedTab,
          children: items
              .map((page) => Navigator(
                    key: page.navKey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [
                        MaterialPageRoute(builder: (context) => page.page)
                      ];
                    },
                  ))
              .toList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, right: 2),
              height: 70,
              child: ElevatedButton(
                onPressed: _pickImageFromCamera,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0F67FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.white, size: 30),
                    Text(
                      'Camera',
                      style: TextStyle(
                        color: Color(0xFFF5F5F5),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        //fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 2),
              height: 70,
              child: ElevatedButton(
                onPressed: _pickImageFromGallery,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0F67FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload, color: Colors.white, size: 30),
                    Text(
                      'Upload',
                      style: TextStyle(
                        color: Color(0xFFF5F5F5),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        //fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavBar(
          currentIndex: selectedTab,
          onTap: (index) {
            print("Tapped index: $index");
            if (index == selectedTab) {
              print("Already on this tab, popping to first route");
              items[index]
                  .navKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                selectedTab = index;
              });
              // Open profile screen without animation when profile icon is clicked
              if (index == 1) {
                items[index].navKey.currentState?.pushReplacement(
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
              }
              // Go back to home screen without animation when home icon is clicked
              if (index == 0) {
                items[index]
                    .navKey
                    .currentState
                    ?.popUntil((route) => route.isFirst);
              }
            }
          },
        ),
      ),
    );
  }

  void _pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      await _processImage(imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      await _processImage(imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _processImage(File imageTemp) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://cddb-128-120-27-120.ngrok-free.app/upload'),
    );
    request.files.add(
      await http.MultipartFile.fromPath('image', imageTemp.path),
    );
    var response = await request.send();
    if (response.statusCode == 200) {
      String predictions = await response.stream.bytesToString();
      Map<String, dynamic> output = json.decode(predictions);
      List<dynamic> diagnoses = output['result'];

      _navigateToDiagnosisScreen(diagnoses, imageTemp);
    } else {
      print('HTTP request failed with status: ${response.statusCode}');
    }
    setState(() => image = imageTemp);
  }

  void _navigateToDiagnosisScreen(diagnoses, imageTemp) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DiagnosisPage(conditions: diagnoses, image: imageTemp)),
    );
  }
}

class TabPage extends StatelessWidget {
  final int tab;

  const TabPage({Key? key, required this.tab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          padding: EdgeInsets.only(left: 15),
                          child: const Text(
                            'Today’s UV Index',
                            style: TextStyle(
                              color: Color(0xFFF5F5F5),
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '7',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' (Moderate)',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 4, // Adjust the height of the line
                  width: double
                      .infinity, // Line spans across the screen horizontally
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Color(0xFFF5F5F5), // Color of the line
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.only(left: 15),
                      child: const Text(
                        'Types of Skin Cancer',
                        style: TextStyle(
                          color: Color(0xFFF5F5F5),
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => AiResults()),
                              // );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF242E49),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                'Bowen’s Disease',
                                style: TextStyle(
                                  color: Color(0xFFF5F5F5),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              // Navigate to desired page
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF242E49),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                'Basal Cell Carcinoma',
                                style: TextStyle(
                                  color: Color(0xFFF5F5F5),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ), // Add space between the texts
                        ],
                      ),
                      SizedBox(height: 10), // Add a space between the rows
                      Row(
                        children: [
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              // Navigate to desired page
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF242E49),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                'Benign Keratosis',
                                style: TextStyle(
                                  color: Color(0xFFF5F5F5),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              // Navigate to desired page
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF242E49),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                'Dermatofibroma',
                                style: TextStyle(
                                  color: Color(0xFFF5F5F5),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10), // Add space between the texts
                          GestureDetector(
                            onTap: () {
                              // Navigate to desired page
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF242E49),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                'Melanoma',
                                style: TextStyle(
                                  color: Color(0xFFF5F5F5),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10), // Add a space between the rows
                      Row(
                        children: [
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              // Navigate to desired page
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF242E49),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                'Melanocytic Nevi',
                                style: TextStyle(
                                  color: Color(0xFFF5F5F5),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              // Navigate to desired page
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF242E49),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                'Vascular Lesions',
                                style: TextStyle(
                                  color: Color(0xFFF5F5F5),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      width: 410,
                      height: 177,
                      decoration: BoxDecoration(
                        color: Color(0xFF242E49),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      width: 410, // Same width as the inner container
                      height: 177, // Same height as the inner container
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey), // Add grey border
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment(0.63, -0.78),
                          end: Alignment(-0.63, 0.78),
                          colors: [Color(0xFF283255), Color(0xFF141A30)],
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10, // Adjust the position as needed
                            left: 20, // Align to the left
                            right: 0,
                            child: Text(
                              '💡 Skin Health Tip of the Day',
                              style: TextStyle(
                                color: Color(0xFFE7E9F1),
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 45,
                            left: 25,
                            right: 10,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Stay out of the sun\n',
                                    style: TextStyle(
                                      color: Color(0xFFFFB04A),
                                      fontWeight:
                                          FontWeight.bold, // Make it bold
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Avoid the sun between 10 AM and 4 PM, when UV rays are strongest. You can also seek shade when your shadow is shorter than you are.',
                                    style: TextStyle(
                                      color: Color(0xFFE7E9F1),
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.only(left: 15),
                      child: const Text(
                        'Articles',
                        style: TextStyle(
                          color: Color(0xFFE7E9F1),
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Container(
                          width: 250,
                          height: 240,
                          decoration: BoxDecoration(
                            color: Color(0xFF141A30),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2, // Take up 2/3 of the available space
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Container(
                                    width: double
                                        .infinity, // Make the width fill the entire container
                                    child: Image.asset(
                                      'assets/Rectangle1.png', // Replace with your image path
                                      fit: BoxFit
                                          .cover, // Fill the available space
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                flex: 1, // Take up 1/3 of the available space
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Skin Cancer Prevention\n',
                                            style: TextStyle(
                                              color: Color(0xFFFFB04A),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                'Discover lifestyle modifications that can lower your risk of developing skin cancer.',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          width: 250,
                          height: 240,
                          decoration: BoxDecoration(
                            color: Color(0xFF141A30),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    child: Image.asset(
                                      'assets/Rectangle2.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Screening Guidelines\n',
                                            style: TextStyle(
                                              color: Color(0xFFFFB04A),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                'Understand recommended guidelines for skin cancer screenings.',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  final int tab;

  const Page({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

Widget _buildCircle(BuildContext context, String label, Route<dynamic> route) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, route);
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF242E49),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
