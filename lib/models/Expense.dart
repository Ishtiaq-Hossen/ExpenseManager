import 'package:expensemanager/enums/catagory_enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
const uuid=Uuid(); //unique id generator
final formatter= DateFormat.yMd(); //for date format
const CatagoryIcons={
  Catagory.food: Icons.lunch_dining,
  Catagory.travel: Icons.airport_shuttle,
  Catagory.leisure: Icons.movie,
  Catagory.work: Icons.work,
};//catagory Icon map

//model class started
class Expense{
  // static const uuid=Uuid();
  final String title;
  final double amount;
  final DateTime date;
  final Catagory catagory;
  final String id;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.catagory,
  }): id=uuid.v4();

  String get formattedDate{
    return formatter.format(date);
  }
}

