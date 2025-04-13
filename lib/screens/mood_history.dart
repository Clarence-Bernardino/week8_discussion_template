import '../Utilities/my_drawer.dart';
import '../screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expenses_provider.dart';

class MoodHistory extends StatelessWidget {
  const MoodHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // listener to retrieve entries information
    var entries = context.watch<EntryHistory>().entries;

    if (entries.isEmpty) {  // if no entries yet, push the empty screen
      Future.delayed(Duration.zero, () {   // wait for flutter to finish the current ui process (MoodHistory)
        // bad idea to switch to another screen while a widget is building
        Navigator.pushReplacementNamed(context, "/empty");
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text("Mood History")),
      body: Consumer<EntryHistory>( // only the body will rebuild when EntryHistory changes
        builder: (context, entryHistory, child) {
          final moodEntries = entryHistory.entries;
          // dynamically build a list view depending on the size of the list
          return ListView.builder(
            itemCount: moodEntries.length,
            itemBuilder: (context, index) {
              final entry = moodEntries[index]; // get entry

              return ListTile(
                title: Text(entry["Name"] ?? "Unknown Name"), // display name, Unknown if null
                subtitle: Text(entry["Date Recorded"] ?? "Unknown Date"), // display date, unknown if null
                leading: Icon(Icons.emoji_emotions),
                trailing: Row(  // trailing texts for the view details and remove
                  mainAxisSize: MainAxisSize.min, // ensure row only takes up the minimum space needed
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push( // DetailsScreen needs a parameter "Entry"
                          context,      // MaterialApp.routes does not allow parameters
                          MaterialPageRoute(  // this type of route allows parameters
                            builder: (context) =>
                                DetailsScreen(entry: entry), 
                          ),
                        );
                      },
                      child: Text("View Details"),
                    ),
                    TextButton(
                      onPressed: () { // when clicked, remove the entry and update the ui
                        context.read<EntryHistory>().removeEntry(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar( // show a message below
                            content:
                                Text("Removed mood entry: ${entry["Mood"]}"),
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Text("Remove"),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      drawer: MyDrawer(),
    );
  }
}
