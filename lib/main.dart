import 'package:flutter/material.dart';
import 'package:google_masp_test/google_map.dart';
import 'package:google_masp_test/home_page.dart';
import 'package:google_masp_test/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CustomBottomNavigationBar(),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CustomBottomNavigationBar> {
  late PageController _pageController;
  int _index = 0;
  bool isOpacity = false;
  List qwer = [
    HomePage(),
    SecondPage(),
    GoogleMap(),
  ];
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _index = index;
                isOpacity = false;
                setState(() {});
              },
              children: [
                AnimatedOpacity(
                  opacity: isOpacity ? 0 : 1,
                  duration: Duration(milliseconds: 500),
                  child: HomePage(),
                ),
                AnimatedOpacity(opacity: isOpacity ? 0 : 1, duration: Duration(milliseconds: 500), child: SecondPage()),
                AnimatedOpacity(opacity: isOpacity ? 0 : 1, duration: Duration(milliseconds: 500), child: GoogleMap()),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        backgroundColor: Colors.black.withOpacity(0.7),
        selectedItemColor: Colors.white12,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "MainScreen"),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: "SecondScreen"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "GoogleMap"),
        ],
        onTap: (index) {
          _index = index;
          _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.linear);
          isOpacity = true;
          setState(() {});
        },
      ),
    );
  }
}
