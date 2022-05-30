import 'package:dio/dio.dart';
import 'package:my_flutter/src/core/params/add_expense_params.dart';
import 'package:my_flutter/src/core/resources/data_state.dart';
import 'package:my_flutter/src/data/datasources/remote/expense_api_service.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';
import 'package:my_flutter/src/domain/repositories/expenses_repository.dart';

class ExpenseRepositoryImpl implements ExpensesRepository {

  final ExpenseAPIService _expenseAPIService;

  const ExpenseRepositoryImpl(this._expenseAPIService);

  @override
  Future<DataState<Expense>> addExpense(AddExpenseParams params) async {
    try {
      final response = await _expenseAPIService.addExpense(params);
      if(response.response.statusCode == 201) {
        return DataSuccess(response.data);
      }else {
        return const DataFailed(null);
      }

    }on Dio catch(e){
      return const DataFailed(null);
    }
  }

  @override
  Future<DataState<List<Expense>>> deleteExpense(String id) async{
    try {
      final response = await _expenseAPIService.deleteExpense(id);
      if(response.response.statusCode == 200) {
        return DataSuccess(response.data);
      } else {
        return const DataFailed([]);
      }

    }on Dio catch(e){
      return const DataFailed([]);
    }
  }

  @override
  Future<DataState<List<Expense>>> getAllExpenses() async {
    try {
      final response = await _expenseAPIService.getAllExpense();
      if(response.response.statusCode == 200) {
        return DataSuccess(response.data);
      } else {
        return const DataFailed([]);
      }

    }on Dio catch(e){
      return const DataFailed([]);
    }
  }

  @override
  Future<DataState<String>> updateExpense(String id , AddExpenseParams params) async {
    try {
      final response = await _expenseAPIService.updateExpense(id , params);
      if(response.response.statusCode == 200) {
        return const DataSuccess("Success!");
      }else {
        return const DataFailed("Failed!");
      }

    }on Dio catch(e){
      return const DataFailed("Failed");
    }
  }

}