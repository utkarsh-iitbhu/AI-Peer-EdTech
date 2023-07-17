// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:inter_iit/pages/aiPeerPage.dart';
import 'package:inter_iit/pages/calendarPage.dart';
import 'package:inter_iit/pages/createPage.dart';
import 'package:inter_iit/pages/homePage.dart';
import 'package:inter_iit/pages/libraryPage.dart';

class HomeScreen extends StatefulWidget {
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int curr_index = 0;
  List<Widget> pages = [
    HomePage(),
    AIPeerPage(),
    CreatePage(),
    LibraryPage(),
    CalendarPage()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    curr_index = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
      ),
      backgroundColor: Color(0xFFFDFDFD),
      body: pages[curr_index],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        currentIndex: curr_index,
        onTap: (index) => setState(() => curr_index = index),
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/home_icon.png"),
              size: 24,
            ),
            label: 'Home',
            activeIcon: ImageIcon(
              AssetImage("assets/home_icon.png"),
              size: 30,
            ),
            // backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/aipeer_icon.png"),
              size: 24,
            ),
            activeIcon: ImageIcon(
              AssetImage("assets/aipeer_icon.png"),
              size: 30,
            ),
            label: 'AI Peer',
            // backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_rounded),
            label: 'Create',
            activeIcon: Icon(
              Icons.add_rounded,
              size: 30,
            ),
            // backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/library_icon.png"),
              size: 24,
            ),
            activeIcon: ImageIcon(
              AssetImage("assets/library_icon.png"),
              size: 30,
            ),
            label: 'Library',
            // backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/calendar_icon.png"),
              size: 24,
            ),
            activeIcon: ImageIcon(
              AssetImage("assets/calendar_icon.png"),
              size: 30,
            ),
            label: 'Tracker',
            // backgroundColor: Colors.blue
          ),
        ],
      ),
    );
  }
}
