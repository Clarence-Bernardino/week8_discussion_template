import 'package:flutter/material.dart';

class EmptyEntriesScreen extends StatelessWidget {
  const EmptyEntriesScreen({super.key});

  @override   // screen will display if there are no entries
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("No Entries Yet")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "No entries yet. Try adding some!",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/add-expense");
              },
              child: const Text("Add Entries"),
            ),
          ],
        ),
      ),
    );
  }
}
