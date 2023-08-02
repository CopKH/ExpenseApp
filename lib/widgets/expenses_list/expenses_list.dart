import 'package:flutter/material.dart';
import 'package:tracker/models/expense.dart';
import 'package:tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemove;
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.1),
              margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
            onDismissed: (direction) {
              onRemove(expenses[index]);
            },
            child: ExpenseItem(
              expense: expenses[index],
            )),
        itemCount: expenses.length);
  }
}
