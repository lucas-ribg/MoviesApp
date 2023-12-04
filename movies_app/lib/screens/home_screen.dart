import 'package:flutter/material.dart';
import 'package:movies_app/screens/movies_screen.dart';
import 'package:movies_app/screens/people_screen.dart';
import 'package:movies_app/screens/search_screen.dart';
import 'package:movies_app/screens/series_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('MovieApp', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          Search(),
          Movies(),
          People(),
          Series(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index, 
              duration: const Duration(milliseconds: 300), 
              curve: Curves.easeInOut
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white),
            label: 'Search'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie, color: Colors.white),
            label: 'Trending Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv, color: Colors.white),
            label: 'Trending TV',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_4, color: Colors.white),
            label: 'Trending People',
          ),
        ],
      ),
    );
  }
}