import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week8datapersistence/Utilities/my_drawer.dart';
import '../providers/expenses_provider.dart';
import 'empty_entries_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {  // instance of the provider
    final expenseProvider = Provider.of<ExpenseListProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      drawer: const MyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: expenseProvider.expense,
        builder: (context, snapshot) {
          
          // handle errors
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // check if we have data and if it's empty
          final hasData = snapshot.hasData;
          final isEmpty = hasData && snapshot.data!.docs.isEmpty;

          if (!hasData || isEmpty) {
            return const EmptyEntriesScreen();
          }

          // default content when there are expenses
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.money_off, size: 64, color: Colors.green),
                SizedBox(height: 16),
                Text("Welcome to your expenses!", style: TextStyle(fontSize: 24)),
                SizedBox(height: 8),
                Text("You have existing expenses.", style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}
