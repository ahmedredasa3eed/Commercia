import 'package:commercia/views/favourite-screen.dart';
import 'package:commercia/views/home_screen.dart';
import 'package:commercia/views/search_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPage = 0;

  List<Widget> screens = [HomeScreen(), SearchScreen(), FavouriteScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentIndex) {
          setState(() {
            _selectedPage = currentIndex;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.deepOrange,
        elevation: 8.0,
        //important
        currentIndex: _selectedPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 33,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,size: 33,),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_sharp,size: 33,),
            label: "Favourite",
          ),
        ],
      ),
      body: screens[_selectedPage],
    );
  }
}
