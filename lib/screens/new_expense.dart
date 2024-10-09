
import 'dart:ffi';

import 'package:expensemanager/enums/catagory_enums.dart';
import 'package:expensemanager/models/Expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
   void _resetCatagoryDropdown(value){
     setState(() {
       _selectedCatagory=value;
     });
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

    return LayoutBuilder(
      builder: (ctx, constrains) {
        // print(constrains.maxWidth);
        // print(constrains.maxHeight);
        final maxWidth=constrains.maxWidth;
        final keyboardspace=MediaQuery.viewInsetsOf(context).bottom;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardspace+16),
                child: Column(
                  children:[
                    maxWidth > 600?
                       Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: TitleWidget(titleController: _titleController)),
                            const SizedBox(width: 16),
                            Expanded(child: AmountWidget(amountController: _amountController)),
                          ],
                        ):
                    //input for title
                    TitleWidget(titleController: _titleController),
                    const SizedBox(height: 16,),

                    maxWidth>600
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CatagoryDropdownWidget(
                            selectedCatagory: _selectedCatagory,
                            onExpenseCatagoryChanged: _resetCatagoryDropdown
                        ),
                        SizedBox(height: 16,),
                        Text(
                            _selectedDate==null ?
                            'Selected Date' : formatter.format(_selectedDate!)
                        ),
                        DatePickWidget(onDateSelected: _presentDatePicker,),
                        CancelButton(),
                        SaveButtonWidget(onPressed: _submitExpenseData
                        )

                      ],
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: AmountWidget(amountController: _amountController)),
                        SizedBox(width: 16 ),
                        Text(
                          _selectedDate==null ?
                            'Selected Date' : formatter.format(_selectedDate!)
                        ), //ternary operator
                        DatePickWidget(onDateSelected: _presentDatePicker,)
                      ],
                    ),
                    const SizedBox(height: 16,),


                    maxWidth>600 ?SizedBox.shrink():
                    Row(
                      children: [
                        //catagory dropdown
                        CatagoryDropdownWidget(
                            selectedCatagory: _selectedCatagory,
                          onExpenseCatagoryChanged: _resetCatagoryDropdown,
                        ),
                        const Spacer(),
                        CancelButton(),
                        SaveButtonWidget(
                          onPressed: _submitExpenseData,
                        ),
                      ],
                    )
                  ]
                )
            ),
          ),
        );
      }
    );
  }
}

class DatePickWidget extends StatelessWidget {

  const DatePickWidget({
    super.key,
    required this.onDateSelected
  });
  final Function() onDateSelected;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onDateSelected,
      icon: Icon(Icons.calendar_month),
    );
  }
}

class CatagoryDropdownWidget extends StatelessWidget {
  final Catagory selectedCatagory;
  final Function(Catagory) onExpenseCatagoryChanged;
  const CatagoryDropdownWidget({
    super.key,
    this.selectedCatagory=Catagory.leisure,
    required this.onExpenseCatagoryChanged,
  }) ;



  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCatagory,
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
          onExpenseCatagoryChanged(value);
        }
    );
  }
}

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    super.key,
    required TextEditingController amountController,
  }) : _amountController = amountController;

  final TextEditingController _amountController;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixText: '\$',
          label: Text('Amount'),
        ),
      );

  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      // onChanged: _saveTitleInput,
      controller: _titleController,
      maxLength:50,
      decoration: InputDecoration(
          label: Text('Title')
      )
    );
  }
}

class SaveButtonWidget extends StatelessWidget {
  final Function() onPressed;
  const SaveButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
     child: Text('Save Expense'));
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Text('Cancel'),
    );
  }
}
