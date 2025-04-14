import 'dart:convert';  // allows JSON string conversion and decoding
import 'package:cloud_firestore/cloud_firestore.dart';  // provides access to firestore db

class Expense { // Expense object
  String? id; // Firestore auto generated id
  String name;
  String description;
  String category;
  double amount;
  bool paid;

  // constructor
  Expense({
    this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.amount,
    required this.paid
  });

  // Factory constructor to turn a firestore document into an Expense object
  factory Expense.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>; // convert the document to a map
    return Expense( // use the converted map to extract the fields
      id: doc.id,
      name: json['name'] ?? '', // provide default value if null
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      amount: json['amount'] ?? 0,
      paid: json['paid'] ?? false
    );
  }
  
  // connverts a JSON string containing a list of expenses into a list of Todo objects in dart
  static List<Expense> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData); // takes JSON text into a Dart map
    return data.map<Expense>((dynamic d) => Expense.fromJson(d)).toList();  // now convert the map to an Expense
  }

  // converts an Expense object to a Map<String, dynamic> so the Firestore can read it
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'amount': amount,
      'paid' : paid
    };
  }
}
