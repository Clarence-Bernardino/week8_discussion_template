import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTodoAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  
  Future<String> addTodo(Map<String, dynamic> todo) async {
    try {
      await db.collection("todos").add(todo);
      return "Successfully added todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}'";
    }
  }

  dynamic getAllTodos() {
    return db.collection("todos").snapshots();
  }

  Future<String> deleteTodo(String id) async {
    try {
      await db.collection("todos").doc(id).delete();
      return "Successfully deleted todo!";
    } on FirebaseException catch (e) {
      return "Failed with error ${e.code}: ${e.message}";
    }
  }

  Future<String> addExpense(Map<String, dynamic> expense) async {
    try {
      await db.collection("expenses").add(expense);
      return "Successfully added expense!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}'";
    }
  }

  dynamic getAllExpenses() {
    return db.collection("todos").snapshots();
  }

  Future<String> deleteExpense(String id) async {
    try {
      await db.collection("expenses").doc(id).delete();
      return "Successfully deleted expense!";
    } on FirebaseException catch (e) {
      return "Failed with error ${e.code}: ${e.message}";
    }
  }
}
