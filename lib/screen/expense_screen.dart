
import 'package:flutter/material.dart';

import 'bottomnavscreen.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {

  _addSheet(){
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        builder:(context)=> BottomNavScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Screen"),
        actions: [
          IconButton(
              onPressed: _addSheet
          , icon: const Icon(Icons.add),
              )
        ],
      ),
    );
  }
}
