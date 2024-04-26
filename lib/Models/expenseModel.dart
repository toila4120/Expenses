import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formater = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff_outlined,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  final int? id;
  final String title;
  final double price;
  final DateTime date;
  final String category;

  const Expense({
    this.id,
    required this.title,
    required this.price,
    required this.date,
    required this.category,
  });

  // Expense.fromMap
  factory Expense.fromMap(Map<String, dynamic> map) {
    return new Expense(
      id: map['id'],
      title: map['title'],
      price: map['price'].toDouble(),
      date: DateTime.parse(map['date']),
      category: map['category'],
    );
  }

// Expense.toMap
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'price': price,
        'date': date.toIso8601String(), // Sử dụng định dạng chuẩn ISO 8601
        'category': category,
      };
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.price;
    }
    return sum;
  }
}
