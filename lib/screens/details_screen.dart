import 'package:flutter/material.dart';
import '../models/expenses_model.dart';
import '../api/firebase_todo_api.dart';

// screen to display and edit expense details
class DetailsScreen extends StatelessWidget {
  final Expense entry;  // expense data to display

  const DetailsScreen({super.key, required this.entry});

  // shows edit dialog with expense details
  void _showEditDialog(BuildContext context) {
    // controllers pre filled with current values
    final nameController = TextEditingController(text: entry.name);
    final descController = TextEditingController(text: entry.description);
    final categoryController = TextEditingController(text: entry.category);
    final amountController = TextEditingController(text: entry.amount.toString());
    bool paid = entry.paid;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Expense'),
          content: SingleChildScrollView(
            child: Column(
              children: [ // children are all editable fields
                TextField(  
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  children: [
                    const Text("Paid"),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: paid,
                      onChanged: (value) {
                        setState(() {
                          paid = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [  // cancel button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),  // save button
            ElevatedButton(
              onPressed: () async { // prep updated expense data
                final updatedExpense = {
                  'name': nameController.text,
                  'description': descController.text,
                  'category': categoryController.text,
                  'amount': double.tryParse(amountController.text) ?? 0.0,
                  'paid': paid,
                };

                try {
                  // update in firestore
                  await FirebaseTodoAPI().editExpense(entry.id, updatedExpense);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Expense updated successfully!")),
                  );
                } catch (e) { // in case of errors
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to update expense: $e")),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entry Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditDialog(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ // expense details display
            Text("Name: ${entry.name}", style: const TextStyle(fontSize: 16)),
            Text("Description: ${entry.description}", style: const TextStyle(fontSize: 16)),
            Text("Category: ${entry.category}", style: const TextStyle(fontSize: 16)),
            Text("Amount: ₱${entry.amount.toStringAsFixed(2)}", style: const TextStyle(fontSize: 16)),
            Text("Paid: ${entry.paid ? "Yes" : "No"}", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
