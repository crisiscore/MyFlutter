import 'package:my_flutter/src/core/resources/data_state.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';
import '../../core/params/add_expense_params.dart';

abstract class ExpensesRepository{
  Future<DataState<List<Expense>>> getAllExpenses();
  Future<DataState<Expense>> addExpense(AddExpenseParams params);
  Future<DataState<String>> updateExpense(String id , AddExpenseParams params);
  Future<DataState<List<Expense>>> deleteExpense(String id);
}