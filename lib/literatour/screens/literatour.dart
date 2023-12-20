import 'package:flutter/material.dart';
import 'package:literatour/bookclub/screens/menu.dart';
import 'package:literatour/bookfinds/screens/bookfinds.dart';
import 'package:literatour/booktalk/screens/booktalk_menu.dart';
import 'package:literatour/literatour/widgets/bottomNavigationBar.dart';
import 'package:literatour/literatour/screens/home.dart';

class LiteratourPage extends StatefulWidget {
  const LiteratourPage({Key? key}) : super(key: key);

  @override
  _LiteratourPageState createState() => _LiteratourPageState();
}

class _LiteratourPageState extends State<LiteratourPage> {
  int _currentIndex = 0;

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  final List _screens = [
    HomePage(),
    BookClubPage(),
    BookfindsPage(),
    BookTalkPage(),
    HomePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(_currentIndex, (index) {
          _updateIndex(index);
        }),
        body: _screens[_currentIndex]);
  }
}
