import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/expenses_provider.dart';
import 'empty_entries_screen.dart';
import 'expense_entry.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseListProvider>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: expenseProvider.expense,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong."));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const EmptyEntriesScreen();
        }

        return const MoodEntry(); // This is your main content when there are entries
      },
    );
  }
}
