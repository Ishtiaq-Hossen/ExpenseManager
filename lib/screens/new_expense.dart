
import 'dart:ffi';

import 'package:expensemanager/enums/catagory_enums.dart';
import 'package:expensemanager/models/Expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  /*
  var _enteredTitle='';
  void _saveTitleInput(String inputValue){
    _enteredTitle=inputValue;
    print(_enteredTitle);
  }
  */
   final _titleController=TextEditingController();
   final _amountController=TextEditingController();
   DateTime? _selectedDate;
   Catagory _selectedCatagory=Catagory.leisure;

   void _presentDatePicker() async{
     final now=DateTime.now();
     final firstDate=DateTime(now.year-1,now.month,now.day);
     final pickedDate= await showDatePicker(context: context,
       initialDate: now,
       firstDate: firstDate,
       lastDate: now,
     );
     setState(() {
       _selectedDate=pickedDate;
     });

   }
   void _submitExpenseData() {
     final enterAmount = double.tryParse(
         _amountController.text); //1.12=> 1.12 ,"Hello"=> null
     final amountIsInvalid = enterAmount == null || enterAmount <= 0;
     //input validation
     if (_titleController.text
         .trim()
         .isEmpty || amountIsInvalid || _selectedDate == null) {
       showDialog(
         context: context,
         builder: (ctx) =>
             AlertDialog(
               title: Text('Invalid Input'),
               content: Text(
                   'Please make sure you have entered valid title,amount,catagory and date.'),
               actions: [
                 TextButton(
                   onPressed: () {
                     Navigator.pop(context);
                   },
                   child: Text('Okay'),
                 ),
               ],
             ),
       );
       return;
     }
     widget.onAddExpense(
       Expense(
       title: _titleController.text,
       amount: enterAmount,
       date: _selectedDate!,
       catagory: _selectedCatagory
       ),
     );
     Navigator.pop(context);
   }
   @override
  void dispose() {
    // TODO: implement dispose
     _titleController.dispose();
     _amountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children:[
            //input for title
            TextField(
              // onChanged: _saveTitleInput,
              controller: _titleController,
              maxLength:50,
              decoration: InputDecoration(
                  label: Text('Title')
              )
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: '\$',
                      label: Text('Amount'),
                    ),
                  ),
                ),
                SizedBox(width: 16 ),
                Text(
                  _selectedDate==null ?
                    'Selected Date' : formatter.format(_selectedDate!)
                ), //ternary operator
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: Icon(Icons.calendar_month),
                )
              ],
            ),
            Row(
              children: [
                //catagory dropdown
                DropdownButton(
                  value: _selectedCatagory,
                    items: Catagory.values.map((catagory)=> DropdownMenuItem(
                        value: catagory,
                        child:
                        Text(
                            catagory.name.toUpperCase(),
                        ),
                    ),
                    ).toList(),
                    onChanged: (value){
                      if(value==null){
                        return;
                      }
                      setState(() {
                        _selectedCatagory=value;
                      });
                    }
                ),
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                ),
                ElevatedButton(onPressed: (){
                  // print(_titleController.text);
                  _submitExpenseData();
                }, child: Text('Save Expense')),
              ],
            )
          ]
        )
    );
  }
}
