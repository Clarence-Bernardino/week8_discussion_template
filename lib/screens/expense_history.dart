import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expenses_model.dart';
import '../providers/expenses_provider.dart';
import '../screens/details_screen.dart';
import '../Utilities/my_drawer.dart';

// screen displaying list of all expenses
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    // access expense provider
    final provider = Provider.of<ExpenseListProvider>(context); // Listening to changes

    return Scaffold(
      appBar: AppBar(title: const Text("Expense History")),
      drawer: const MyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: provider.expense, // listen to expense stream
        builder: (context, snapshot) {
          debugPrint("StreamBuilder state: ${snapshot.connectionState}");
          // handle errors, present a retry button if detected
          if (snapshot.hasError) {
            debugPrint("Stream error: ${snapshot.error}");
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  Text('Error: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: provider.fetchExpenses,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // handle empty state
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No expenses found. Add some expenses!'),
            );
          }

          return ListView.separated(  // display list of expenses
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              try { // parse expense data
                final expense = Expense.fromJson(doc);
                return ListTile(
                  leading: const Icon(Icons.monetization_on),
                  title: Text(expense.name),
                  subtitle: Text(
                    "₱${expense.amount.toStringAsFixed(2)} • ${expense.category}",
                  ),
                  trailing: Wrap(
                    spacing: 8,
                    children: [
                      // viw details button
                      IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(entry: expense),
                            ),
                          );
                        },
                      ),
                      IconButton( // delete button
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await provider.deleteExpense(expense);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Deleted expense: ${expense.name}"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );  // handle errors on parsing
              } catch (e) { // e contains the exception
                debugPrint("Error parsing expense: $e");
                return ListTile(
                  title: Text("Error loading expense ${doc.id}"),
                );
              }
            },
          );
        },
      ),
    );
  }
}
