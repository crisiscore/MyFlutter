import 'package:my_flutter/src/domain/entities/expense.dart';

class ExpenseModel extends Expense {

  const ExpenseModel({
    String ? id, required int amount, required String description
  }) : super(id: id, amount: amount, description: description);

  factory ExpenseModel.fromJson(Map<String, dynamic> ? map){
    if (map == null) return const ExpenseModel(amount: 0, description:'',id: '');
    return ExpenseModel(
        id: map['_id'] as String,
        amount: map['amount'] as int,
        description: map['description'] as String
    );
  }


}