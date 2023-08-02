import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  String get formaattedDate {
    return formatter.format(date);
  }

  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
}

class ExpenseBucket {
  ExpenseBucket.forCategory(List<Expense> allExpense,this.category) : expenses = allExpense.where((element) => element.category == category).toList();
  final List<Expense> expenses;
  final Category category;
  double get totalExpenses {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }

  ExpenseBucket(this.expenses, this.category);
}
