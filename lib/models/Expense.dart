import 'package:expensemanager/enums/catagory_enums.dart';
import 'package:uuid/uuid.dart';
const uuid=Uuid();
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
}

final exp=Expense(
    title: "title",
    amount: 88,
    date: DateTime.now(),
    catagory: Catagory.food,
);