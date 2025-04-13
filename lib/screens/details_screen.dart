import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, String> entry; // receive the entry data

  const DetailsScreen({super.key, required this.entry});

  @override   // screen to display entries
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Entry Details")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
          children: [
            Text("Name: ${entry["Name"]}", style: TextStyle(fontSize: 16)),
            Text("Age: ${entry["Age"]}", style: TextStyle(fontSize: 16)),
            Text("Exercise: ${entry["Exercise"]}", style: TextStyle(fontSize: 16)),
            Text("Mood: ${entry["Mood"]}", style: TextStyle(fontSize: 16)),
            Text("Weather: ${entry["Weather"]}", style: TextStyle(fontSize: 16)),
            Text("Date Recorded: ${entry["Date Recorded"]}", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
