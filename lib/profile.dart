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
      body: Stack(children: [
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
                          'Hello, Simon Gooden',
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 26,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Placeholder for icon, you can replace this with your icon widget
                        Icon(
                          Icons.edit,
                          color: Color(0xFF0F67FD), // Match the color with text
                        ),
                        SizedBox(
                            width:
                                0), // Adjust the width as needed for spacing between icon and text
                        Text(
                          'Edit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF0F67FD),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                            width: 16), // Add padding to the right of the text
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/scan.png',
                        width: 60, // Adjust the width of the image as needed
                        height: 60, // Adjust the height of the image as needed
                      ),
                      SizedBox(
                          height:
                              4), // Adjust the height for spacing between image and text
                      Text(
                        '8',
                        style: TextStyle(
                          color: Color(0xFFFFB04A),
                          fontSize: 30,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        width: 94,
                        child: Text(
                          'Scans completed',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width:
                          40), // Add flexible space between the first and second images
                  Column(
                    children: [
                      Image.asset(
                        'assets/megaphone.png',
                        width: 60, // Adjust the width of the image as needed
                        height: 60, // Adjust the height of the image as needed
                      ),
                      SizedBox(
                          height:
                              4), // Adjust the height for spacing between image and text
                      Text(
                        '2',
                        style: TextStyle(
                          color: Color(0xFFFFB04A),
                          fontSize: 30,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        width: 94,
                        child: Text(
                          'Need Attention',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width:
                          40), // Add flexible space between the second and third images
                  Column(
                    children: [
                      Image.asset(
                        'assets/happy.png',
                        width: 60, // Adjust the width of the image as needed
                        height: 60, // Adjust the height of the image as needed
                      ),
                      SizedBox(
                          height:
                              4), // Adjust the height for spacing between image and text
                      Text(
                        '6',
                        style: TextStyle(
                          color: Color(0xFFFFB04A),
                          fontSize: 30,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        width: 94,
                        child: Text(
                          'Do Not Need Attention',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 200,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          'Scans History',
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Placeholder for icon, you can replace this with your icon widget
                        Text(
                          'Sort',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        SizedBox(width: 0),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFFF5F5F5), // Match the color with text
                        ),
                        SizedBox(
                            width: 16), // Add padding to the right of the text
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                height: 200,
                padding: const EdgeInsets.all(20),
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.63, -0.78),
                    end: Alignment(-0.63, 0.78),
                    colors: [Color(0xFF283255), Color(0xFF141A30)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Change this to CrossAxisAlignment.start
                  children: [
                    Container(
                      width: 143,
                      height: 143,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/Rectangle72.png"),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Container(
                      width: 162,
                      height: 150,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 147,
                                  child: Text(
                                    'Simon Skin',
                                    style: TextStyle(
                                      color: Color(0xFFF5F5F5),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 151,
                                  child: Text(
                                    '04/27/2024',
                                    style: TextStyle(
                                      color: Color(0xFFF5F5F5),
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 19),
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 147,
                                        child: Text(
                                          'Result',
                                          style: TextStyle(
                                            color: Color(0xFFF5F5F5),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 162,
                                        child: Text(
                                          'No signs of symptoms',
                                          style: TextStyle(
                                            color: Color(0xFFF5F5F5),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 147,
                                        child: Text(
                                          'Level of Concern',
                                          style: TextStyle(
                                            color: Color(0xFFF5F5F5),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 162,
                                        child: Text(
                                          'Does not need attention',
                                          style: TextStyle(
                                            color: Color(0xFFF5F5F5),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
