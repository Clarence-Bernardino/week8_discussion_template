import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../api/firebaseTodoAPI.dart';

class TodoListProvider with ChangeNotifier {
  late Stream<QuerySnapshot> _todosStream;
  late FirebaseTodoAPI firebaseService;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  TodoListProvider() {
    firebaseService = FirebaseTodoAPI();
    fetchTodos();
  }

  // getter
  Stream<QuerySnapshot> get todo => _todosStream;

  // TODO: get all todo items from Firestore
  void fetchTodos() {
    _todosStream = firebaseService.getAllTodos();
    notifyListeners();
  }

  // DONE : add todo item and store it in Firestore
  void addTodo(Todo item) async {
    firebaseService.addTodo(item.toJson(item));
    notifyListeners();
  }

  // TODO: edit a todo item and update it in Firestore
  Future<void> editTodo(Todo item, String newTitle) async {
  if (item.id != null) {
    await db.collection("todos").doc(item.id!).update({
      'title': newTitle,
    });
    notifyListeners();
  }
  }

  // DONE: delete a todo item and update it in Firestore
  void deleteTodo(Todo item) async {
    if (item.id != null) {
      await firebaseService.deleteTodo(item.id!);
      notifyListeners();
    } else {
      debugPrint("Cannot delete todo - ID is null");
    }
  }

  // TODO: modify a todo status and update it in Firestore
  Future<void> toggleStatus(Todo item, bool status) async {
  if (item.id != null) {
    await db.collection("todos").doc(item.id!).update({
      'completed': status,
    });
    notifyListeners();
  }
}
}
