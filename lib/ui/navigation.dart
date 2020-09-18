import 'package:Prolx/ui/addProduct.dart';
import 'package:Prolx/ui/homePage.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'drawerWidget.dart';

class Navigation extends StatefulWidget {
  Navigation({Key key}) : super(key: key);
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Prolx',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          HomePage(),
          Dashboard(),
          AddProduct(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        notchMargin: 5,
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                title: Text('Home'), icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                title: Text('Dashboard'), icon: Icon(Icons.dashboard)),
            BottomNavigationBarItem(
                title: Text('Add Product'), icon: Icon(Icons.add_box))
          ],
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          selectedItemColor: Colors.redAccent,
        ),
      ),
    );
  }
}
