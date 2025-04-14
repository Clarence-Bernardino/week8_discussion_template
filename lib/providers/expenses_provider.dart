import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/expenses_model.dart';
import '../api/firebase_todo_api.dart';

class ExpenseListProvider with ChangeNotifier {
  late Stream<QuerySnapshot> _expensesStream; // real time data of the expenses collection
  late FirebaseTodoAPI firebaseService = FirebaseTodoAPI(); // enables program to firebase communication

  ExpenseListProvider() {
    fetchExpenses();  // initialize with expense data
  }

  // getter
  Stream<QuerySnapshot> get expense => _expensesStream;

  // exposes expenses stream to widgets
  void fetchExpenses() {
    _expensesStream = firebaseService.getAllExpenses()
      .handleError((error) {  // in case of any errors
        debugPrint("Error fetching expenses: $error");
      });
    notifyListeners(); // trigger UI updates
  }

  // adds a new expense to Firestore
  Future<void> addExpense(Expense item) async {
    await firebaseService.addExpense(item.toJson());
  }

  // edits an existing expense in Firestore
  Future<void> editExpense(Expense item, String newName, String newDescription, String newCategory, double newAmount, bool newPaidStatus) async {
    if (item.id != null) {
      await firebaseService.editExpense(
        item.id!,
        {
          'name' : newName,
          'description': newDescription,
          'category': newCategory,
          'amount': newAmount,
          'paid' : newPaidStatus 
        }
      );
    }
  } 

  // delete a todo item and update it in Firestore
  Future<void> deleteExpense(Expense item) async {
    if (item.id != null) {
      await firebaseService.deleteExpense(item.id!);
    } else {
      debugPrint("Cannot delete expense - ID is null");
    }
  }
}