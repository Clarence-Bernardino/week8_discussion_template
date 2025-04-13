import 'package:flutter/material.dart';

// statefulWidget for the navigation drawer
class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

// state class for MyDrawer
class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // header text
          DrawerHeader(
            child: Text("Mood Tracker", style: TextStyle(fontSize: 32, fontStyle: FontStyle.italic)), // Title for the drawer
          ),
          // navigation options
          _createListTileRoute("Add an Entry", "/entries"), // Navigate to Add an Entry screen
          _createListTileRoute("Mood History", "/history"), // Navigate to Mood Entries screen
        ],
      ),
    );
  }

  // helper method to create navigation list tiles
  ListTile _createListTileRoute(String display, String route) {
    return ListTile(
      title: Text(display), // display the given title
      onTap: () {
        Navigator.pushNamed(context, route); // navigate to the given route
      },
    );
  }
}