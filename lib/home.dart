import 'package:flutter/material.dart';
import 'package:quadb_assignment/home_page.dart';
import 'package:quadb_assignment/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    int _index = 0;
  static final List _widgets = [
    const HomePage(),
    const Search(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedItemColor: const Color.fromARGB(255, 31, 128, 224),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.house_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'Search'),
          ],
          currentIndex: _index,
          onTap: _onItemTapped),
      body: _widgets.elementAt(_index),
    );
  }
}
