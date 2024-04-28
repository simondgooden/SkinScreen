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
          height: 100,
          width: 100,
          child: FloatingActionButton(
            backgroundColor: Color(0xFF0F67FD),
            elevation: 0,
            onPressed: () => debugPrint("Add Button pressed"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Container(
              width: 150, // Adjust the width of the image
              height: 150, // Adjust the height of the image
              child: Image.asset(
                'assets/Vector.png', // Replace 'assets/vector.png' with your image path
              ),
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
                  height: 90,
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
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 25,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '7 ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFF5F5F5),
                                fontSize: 20,
                                fontFamily: 'Outfit',
                                fontWeight:
                                    FontWeight.w700, // Bold the number "7"
                                height: 0,
                              ),
                            ),
                            const Text(
                              '(Moderate)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFF5F5F5),
                                fontSize: 20,
                                fontFamily: 'Outfit',
                                height: 0,
                              ),
                            ),
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
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 15),
                    child: const Text(
                      'Types of Skin Cancer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFF5F5F5),
                        fontSize: 25,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        _buildCircle('AKEIC', () {
                          print('Button tapped: AKEIC');
                        }),
                        SizedBox(width: 15),
                        _buildCircle('BCC', () {
                          print('Button tapped: BCC');
                        }),
                        SizedBox(width: 15),
                        _buildCircle('BKL', () {
                          print('Button tapped: BCC');
                        }),
                        SizedBox(width: 15),
                        _buildCircle('DF', () {
                          print('Button tapped: BCC');
                        }),
                        SizedBox(width: 15),
                        _buildCircle('MEL', () {
                          print('Button tapped: BCC');
                        }),
                        SizedBox(width: 15),
                        _buildCircle('NV', () {
                          print('Button tapped: BCC');
                        }),
                        // Repeat for other circles
                      ],
                    ),
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
                      ),
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
                            top: 60,
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
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFF5F5F5),
                        fontSize: 25,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
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

Widget _buildCircle(String text, VoidCallback onTap) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
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
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
