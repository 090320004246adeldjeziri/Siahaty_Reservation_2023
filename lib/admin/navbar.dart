import 'package:cabina/admin/home.dart';
import 'package:cabina/admin/screenChoice.dart';
import 'package:cabina/admin/users_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../cabine_item.dart';
import 'cabine_add.dart'; // Import the CabItem class

class ad extends StatefulWidget {
  const ad({Key? key}) : super(key: key);

  @override
  _adState createState() => _adState();
}

class _adState extends State<ad> {
  int _selectedIndex = 0;

  // Define your separate pages for each tab
  final List<Widget> _pages = [
    AdminHome(), // Replace with your actual home screen widget
    ListUsers(), // Replace with your actual dashboard screen widget
    ReqItemCabListScreen(), // Replace with your actual settings screen widget
    ProfileScreen(), // Replace with your actual profile screen widget
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: NavBar(
          currentIndex: _selectedIndex,
          onTabChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  NavBar({required this.currentIndex, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabChanged,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black),
          label: 'Home',
          backgroundColor: Colors.redAccent,
          // TODO make sure to make  navbar better than this ! //
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.redAccent,
          icon: Icon(
            Icons.people,
            color: Colors.black,
          ),
          label: 'List Users',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.redAccent,
          icon: Icon(Icons.add_home_sharp, color: Colors.black),
          label: 'New Cabine !',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.redAccent,
          icon: Icon(Icons.person, color: Colors.black),
          label: 'Profile',
        ),
      ],
    );
  }
}

// Create your separate screen classes for each tab
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your content for the Home screen
    return const ad();
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your content for the Profile screen
    return Container();
  }
}
