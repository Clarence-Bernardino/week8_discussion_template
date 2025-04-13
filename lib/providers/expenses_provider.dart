import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/expenses_model.dart';
import '../api/firebaseTodoAPI.dart';

class ExpenseListProvider with ChangeNotifier {
  late Stream<QuerySnapshot> _ExpensesStream;
  late FirebaseTodoAPI firebaseService;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  ExpenseListProvider() {
    firebaseService = FirebaseTodoAPI();
    fetchExpenses();
  }

  // getter
  Stream<QuerySnapshot> get expense => _ExpensesStream;

  // TODO: get all todo items from Firestore
  void fetchExpenses() {
    _ExpensesStream = firebaseService.getAllExpenses();
    notifyListeners();
  }

  // DONE : add todo item and store it in Firestore
  void addExpense(Expense item) async {
    firebaseService.addTodo(item.toJson(item));
    notifyListeners();
  }

  // TODO: edit a todo item and update it in Firestore
  Future<void> editTodo(Expense item, String newName, String newDescription, String newCategory, double newAmount) async {
  if (item.id != null){
    await db.collection("Expenses").doc(item.id!).update({
      'name': newName,
      'description': newDescription,
      'category': newCategory,
      'amount': newAmount
    });
    notifyListeners();
  }
  }

  // DONE: delete a todo item and update it in Firestore
  void deleteTodo(Expense item) async {
    if (item.id != null) {
      await firebaseService.deleteTodo(item.id!);
      notifyListeners();
    } else {
      debugPrint("Cannot delete todo - ID is null");
    }
  }
}

// used to be in the mood_entry_provider.dart:

// import 'package:flutter/widgets.dart';

// class EntryHistory with ChangeNotifier {
//   final List<Map<String, String>> _entries = []; // private list
//   List<Map<String, String>> get entries => _entries; // public getter

//   void addEntry(Map<String, String> entry) {
//     _entries.add(entry);
//     notifyListeners();  // tells all listening widgets to rebuild when the state changes.
//   }

//   void removeEntry(int i) {
//     _entries.removeAt(i);
//     notifyListeners(); // only functions that call notifyListeners() will trigger updates
//   }
// }