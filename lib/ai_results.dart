import 'package:flutter_app/home.dart';
import 'package:flutter/material.dart';

class AiResults extends StatefulWidget {
  const AiResults({super.key});

  @override
  State<AiResults> createState() => _AiResultsState();
}

class _AiResultsState extends State<AiResults> {
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
            ],
          ),
        ),
      ]),
    );
  }
}
