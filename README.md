# exer8
Name: Clarence Joshua T. Bernardino
Section: UV-2L
Student number: 2023 - 00166

Description
I did an application that is a simple expense tracker where the user can add, edit, delete and view their expenses. The data inserted will persist by using an online database Firestore. 

Challenges encountered
The whole Firestore operations were new so they took some time to learn. The provider kept getting lost when navigating so I had to learn to use a different push method called pushNamedAndRemoveUntil. 

Solutions
Reading the docs and googling.

Structure
api
-firebase_todo_api.dart 

models
-expenses_model.dart
-todo_model.dart

providers
-expenses_provider.dart
-todo_provider.dart

screens
-details_screen.dart
-empty_entries_screen.dart
-expense_entry.dart
-expense_history.dart
-home_scree.dart
-modal_todo.dart
-todo_page.dart

api - Uses snapshots to access data from the Firestore once (Future) or continously (Stream).
https://stackoverflow.com/questions/67049608/what-is-a-snapshot-in-flutter
https://pub.dev/packages/snapshot

models - Describes what a Todo or Expense object is and handles the conversion of the object to a JSON readable format and vice versa. 
https://dart.dev/libraries/dart-convert

providers - Enables the CRUDE operations in tandem with the api files.
https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html
https://stackoverflow.com/questions/50687633/flutter-how-can-i-add-divider-between-each-list-item-in-my-code

screens - The interface for the CRUDE operations.

utilities - contains the drawer, theme, and widgets
https://www.youtube.com/watch?v=-bpormXYA8g
https://stackoverflow.com/questions/45889341/flutter-remove-all-routes 