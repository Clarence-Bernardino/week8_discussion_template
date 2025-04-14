import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTodoAPI {
  // create an instance of the Firestore database
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  // add a new todo document to the Firestore
  Future<String> addTodo(Map<String, dynamic> todo) async {
    try {
      await _db.collection("todos").add(todo);
      return "Successfully added todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}'";
    }
  }
  // get real-time stream of all todos
  dynamic getAllTodos() {
    return _db.collection("todos").snapshots();
  }

  // delete a todo  documents from its id
  Future<String> deleteTodo(String id) async {
    try {
      await _db.collection("todos").doc(id).delete();
      return "Successfully deleted todo!";
    } on FirebaseException catch (e) {
      return "Failed with error ${e.code}: ${e.message}";
    }
  }

  // get all the expenses documents
  Stream<QuerySnapshot> getAllExpenses() {
    try {
      return _db.collection("expenses").snapshots();
    } catch (e) {
      print("Error in getAllExpenses: $e");
      rethrow;
    }
  }
  
  // add a new expense document to the FIrestore
  Future<void> addExpense(Map<String, dynamic> expense) async {
    await _db.collection("expenses").add(expense);
  }

  // update an expense document by editing
  Future<void> editExpense(String? id, Map<String, dynamic> updates) async {
    await _db.collection("expenses").doc(id).update(updates);
  }

  // delete an expense document
  Future<void> deleteExpense(String id) async {
    await _db.collection("expenses").doc(id).delete();
  }
}
