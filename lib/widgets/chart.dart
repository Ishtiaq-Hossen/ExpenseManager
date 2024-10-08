
import 'dart:ffi';

import 'package:expensemanager/widgets/chart-bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enums/catagory_enums.dart';
import '../models/Expense.dart';

class Chart extends StatelessWidget {
  final List<Expense>expenses;
  const Chart({super.key,required this.expenses});

  //buckets
  List<ExpenseBucket> get buckets{
    return [

      ExpenseBucket.forCatagory(expenses, Catagory.food),
      ExpenseBucket.forCatagory(expenses, Catagory.leisure),
      ExpenseBucket.forCatagory(expenses, Catagory.travel),
      ExpenseBucket.forCatagory(expenses, Catagory.work),
    ];

  }



  double get maxTotalExpense{
    double maxTotalExpense=0;
    for(final bucket in buckets){//for in loop
      if(bucket.TotalExpenses>maxTotalExpense){
        maxTotalExpense=bucket.TotalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode= MediaQuery.of(context).platformBrightness==Brightness.dark;

    return Container(
      margin: EdgeInsets.all(16),//all mane sob dik theke
      padding: EdgeInsets.symmetric(// symetric mane upre,niche ba dane,bame
        horizontal: 8,
        vertical: 16,
      ),//
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        // color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),

      ),
      child: Column(
        children: [
          //bar
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for(final bucket in buckets)
                  ChartBar(
                    fill: bucket.TotalExpenses==0
                        ?0
                        :bucket.TotalExpenses /maxTotalExpense,
                  ),
              ],
            ),
          ),
          

          SizedBox(
            height: 32,
          ),
          Row(
            children: buckets.map((bucket) => Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: Icon(
                    CatagoryIcons[bucket.catagory],

                    color:isDarkMode
                        ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.7)
                ),
                ),
            )).toList(),
          ),
        ],

      ),

    );
  }
}
