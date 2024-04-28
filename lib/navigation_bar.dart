import 'dart:io';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({
    Key? key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 0,
        right: 0,
        bottom: Platform.isAndroid ? 16 : 0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Set border radius here
        child: BottomAppBar(
          elevation: 0.0,
          shape: CircularNotchedRectangle(),
          color: Color(0xFF242E49),
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => onTap(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home, size: 35, color: pageIndex == 0 ? Color(0xFFFF9000) : Color(0xFFE7E9F1)),
                        Text('Home', style: TextStyle(color: pageIndex == 0 ? Color(0xFFFF9000) : Color(0xFFE7E9F1))),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => onTap(1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, size: 35, color: pageIndex == 1 ? Color(0xFFFF9000) : Color(0xFFE7E9F1)),
                        Text('Profile', style: TextStyle(color: pageIndex == 1 ? Color(0xFFFF9000) : Color(0xFFE7E9F1))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
