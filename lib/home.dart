import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 35, // Adjust the size as needed
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.access_time,
                  size: 40), // Adjust the size as needed
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.access_time,
                  size: 40), // Adjust the size as needed
              title: const Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
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
                      SizedBox(width:20), // Adjust the space between circles as needed
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
                      SizedBox(width:20), // Adjust the space between circles as needed
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
                      SizedBox(width:20), // Adjust the space between circles as needed
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
                  height: 20,
                ),
                Container(
                  width: 300,
                  height: 177,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(31),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), // Corrected icon for the fourth option
            label: 'Settings', // Label for the new fourth button
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Color.fromARGB(255, 112, 175, 238),
        unselectedItemColor: Colors.grey,
        //onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }
}
