import 'package:flutter/material.dart';

// custom drawer widget for app navigation
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // remove default padding
        children: [
          // drawer header with title
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Navigation",
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          // home navigation item
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context); // close drawer
              // add new route to stack
              // remove all previous rutes until condition is met
              // route => false: condition that means remove all previous routes
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',  // go to home
                (route) => false, // clear everything opened before
              );
            },
          ),
          // add expense navgiation item
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("Add Expense"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/add-expense', // go to add-expense
                (route) => false, // clear everything opened before
              );
            },
          ),
          // expense history navigation item
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text("All Expenses"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/expense-history',
                (route) => false,
              );
            },
          ),
          // todo list navigation item
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text("Todo List"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
