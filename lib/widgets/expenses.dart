import 'package:flutter/material.dart';
import 'package:tracker/widgets/cart/cart.dart';
import 'package:tracker/widgets/expenses_list/expenses_list.dart';
import 'package:tracker/models/expense.dart';
import 'package:tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenses = [
    // Expense(
    //     title: 'Flutter Course',
    //     amount: 19.99,
    //     date: DateTime.now(),
    //     category: Category.work),
    // Expense(
    //     title: 'Cinema',
    //     amount: 15.69,
    //     date: DateTime.now(),
    //     category: Category.leisure),
  ];

  void _openAdd() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars(); 
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Expense deleted'),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );
    if (_expenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expenses,
        onRemove: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Expenses App',
        ),
        // backgroundColor: Colors.amber,
        // foregroundColor: Colors.amber,
        actions: [IconButton(onPressed: _openAdd, icon: const Icon(Icons.add))],
      ),
      body: Column(
        children: [Chart(expenses: _expenses,), Expanded(child: mainContent)],
      ),
    );
  }
}


