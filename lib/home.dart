import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/navigation_bar.dart';
import 'package:flutter_app/navigation_model.dart';
import 'package:flutter_app/profile.dart';

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
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 64,
          width: 64,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: () => debugPrint("Add Button pressed"),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: Colors.green),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.green,
            ),
          ),
        ),
        bottomNavigationBar: NavBar(
          pageIndex: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              items[index]
                  .navKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                selectedTab = index;
              });
              // Open profile screen when profile icon is clicked
              if (index == 1) {
                items[index].navKey.currentState?.push(
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
                  height: 50,
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

class Page extends StatelessWidget {
  final int tab;

  const Page({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
