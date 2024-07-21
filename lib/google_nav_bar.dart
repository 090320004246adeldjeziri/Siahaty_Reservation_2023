import 'package:cabina/add_cabine.dart';
import 'package:cabina/profile.dart';
import 'package:cabina/saved_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'cabine_item.dart';
import 'home_page.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    homeAdd(),
    CabineInfoPage(),
    SavedScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.transparent, // Set the color to transparent
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.yellow,
              hoverColor: Colors.red,
              gap: 8,
              activeColor: Colors.lightBlueAccent,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.transparent.withOpacity(0.2),
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Accueil',
                ),
                GButton(
                  icon: Icons.add_home,
                  text: 'Ajouter Cabine',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Enregistrement',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  fetchDataFromFirestore();
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
