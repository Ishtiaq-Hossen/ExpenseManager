
import 'package:expensemanager/screens/new_expense.dart';
import 'package:flutter/material.dart';

import '../enums/catagory_enums.dart';
import '../models/Expense.dart';
import '../widgets/expenseList.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  //dummy data
  final List<Expense> _registeredExpenses=[ //list of expenses that will show in expanded widget
    /*
    Expense(title: 'Flutter course',
        amount: 23,
        date: DateTime.now(),
        catagory: Catagory.food),
    Expense(title: 'Web course',
        amount: 25.99,
        date: DateTime.now(),
        catagory: Catagory.leisure),
  */
  ];
  void _openAddExpenseModal(){
    showModalBottomSheet(
        context: context,
        builder: (ctx)=>NewExpense(onAddExpense: _addExpense)
    );
  }
  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        title: Text('Expense Manager'),
        actions: [
          IconButton(onPressed: _openAddExpenseModal, icon: Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ExpenseList(
                expenses: _registeredExpenses,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
