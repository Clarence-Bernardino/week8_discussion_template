import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String? id; // Firestore auto generated id
  String title;
  bool completed;

  // constructor
  Todo({
    this.id,
    required this.title,
    required this.completed,
  });

  // Factory constructor to instantiate object from json format
  factory Todo.fromJson(DocumentSnapshot doc) { // documentSnapshot for reading Firestore data 
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Todo(
      id: doc.id,
      title: json['title'] ?? '', // provide default value if null
      completed: json['completed'] ?? false,  // provide defssult value false if null
    );
  }

  static List<Todo> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Todo>((dynamic d) => Todo.fromJson(d)).toList();
  }

  // converts a Todo object to a Firestore-friendly Map
  Map<String, dynamic> toJson(Todo todo) {
    return {
      'title': title,
      'completed': completed,
    };
  }
}
