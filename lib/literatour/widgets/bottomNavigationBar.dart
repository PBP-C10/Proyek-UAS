import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

BottomNavigationBar buildBottomNavigationBar(
    int currentIndex, void Function(int) onTap) {
  return BottomNavigationBar(
    backgroundColor: Colors.indigo,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
    selectedIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    unselectedIconTheme: const IconThemeData(
      color: Colors.white70,
    ),
    selectedLabelStyle: GoogleFonts.lato(),
    unselectedLabelStyle: GoogleFonts.lato(),
    iconSize: 30,
    currentIndex: currentIndex,
    onTap: onTap,
    type: BottomNavigationBarType.fixed,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.forum),
        label: 'Book Club',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Catalogue',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.reviews),
        label: 'Book Talk',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'Profile',
      ),
    ],
  );
}
