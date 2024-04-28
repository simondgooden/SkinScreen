import 'package:flutter_app/home.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 15),
                    child: const Text(
                      'Types of Skin Cancer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF313131),
                        fontSize: 30,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center the circles horizontally
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              // You can customize other properties of the CircleAvatar as needed
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Text 1',
                            style: TextStyle(
                              fontSize: 14,
                              // Add more text styles as needed
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          width:
                              20), // Adjust the space between circles as needed
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              // You can customize other properties of the CircleAvatar as needed
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Text 2',
                            style: TextStyle(
                              fontSize: 14,
                              // Add more text styles as needed
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          width:
                              20), // Adjust the space between circles as needed
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              // You can customize other properties of the CircleAvatar as needed
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Text 3',
                            style: TextStyle(
                              fontSize: 14,
                              // Add more text styles as needed
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          width:
                              20), // Adjust the space between circles as needed
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                              backgroundColor: Colors.yellow,
                              // You can customize other properties of the CircleAvatar as needed
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Text 4',
                            style: TextStyle(
                              fontSize: 14,
                              // Add more text styles as needed
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Stack(
                  children: [
                    Container(
                      width: 378,
                      height: 177,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 245, 245),
                        borderRadius: BorderRadius.circular(31),
                      ),
                    ),
                    Positioned(
                      top: 10, // Adjust the position as needed
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'Skin Health Tip',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            // Add more text styles as needed
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60, // Adjust the position as needed
                      left: 10,
                      right: 10,
                      child: Text(
                        'Stay out of the sun\nAvoid the sun between 10 AM and 4 PM, when UV rays are strongest. You can also seek shade when your shadow is shorter than you are.',
                        style: TextStyle(
                          fontSize: 14,
                          // Add more text styles as needed
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}