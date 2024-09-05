
import 'package:expensemanager/widgets/expenseListItem.dart';
import 'package:flutter/material.dart';

import '../models/Expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense>expenses;
  const ExpenseList({super.key,
  required this.expenses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context,index) =>
          ExpenseListItem(expense: expenses[index]));
  }
}
