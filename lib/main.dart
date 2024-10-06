import 'package:expensemanager/screens/expense_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true
    ),
    home: ExpenseScreen(),
  ));
}
