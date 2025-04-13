import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  String? id; // Firestore auto generated id
  String name;
  String description;
  String category;
  // List<String> category = ["Bills", "Transportation", "Food", "Utilities", 
  // "Health", "Entertainment", "Miscellaneous"];
  double amount;

  // constructor
  Expense({
    this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.amount
  });

  // Factory constructor to instantiate object from json format
  factory Expense.fromJson(DocumentSnapshot doc) { // documentSnapshot for reading Firestore data 
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Expense(
      id: doc.id,
      name: json['name'], // provide default value if null
      description: json['description'],
      category: json['category'],
      amount: json['amount'],
    );
  }
  
  // connverts a JSON string containing a list of expenses into a list of Todo objects in dart
  static List<Expense> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Expense>((dynamic d) => Expense.fromJson(d)).toList();
  }

  // converts a Todo object to a Firestore-friendly Map
  Map<String, dynamic> toJson(Expense expense) {
    return {
      'name': name,
      'description': description,
      'category': category,
      'amount': amount,
    };
  }
}
