import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;
  final int currentIndex;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
    this.currentIndex = 0, // Provide a default value for currentIndex
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: [
        BottomNavigationBarItem(
          backgroundColor:Color(0xff2a2d36),
          icon: Icon(Icons.home, color: _getColor(0)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor:Color(0xff2a2d36),
          icon: Icon(Icons.search, color: _getColor(1)),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          backgroundColor:Color(0xff2a2d36),
          icon: Icon(Icons.play_circle, color: _getColor(2)),
          label: 'For You ',
        ),
        BottomNavigationBarItem(
          backgroundColor:Color(0xff2a2d36),
          icon: Icon(Icons.manage_accounts, color: _getColor(3)),
          label: 'My Library',
        ),
        BottomNavigationBarItem(
          backgroundColor:Color(0xff2a2d36),
          icon: Icon(Icons.dashboard, color: _getColor(4)),
          label: 'pro',
        ),
      ],

      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    );
  }

  Color _getColor(int index) {
    return currentIndex == index
        ? Colors.white
        : const Color.fromARGB(255, 128, 128, 128);
  }
}
