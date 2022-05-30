import 'package:dio/dio.dart';
import 'package:my_flutter/src/core/constants.dart';
import 'package:my_flutter/src/core/params/add_expense_params.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/expense_model.dart';

part 'expense_api_service.g.dart';

@RestApi(baseUrl : kBaseUrl)
abstract class ExpenseAPIService{

  factory ExpenseAPIService(Dio dio , {String baseUrl}) = _ExpenseAPIService;

  @GET('expenses')
  Future<HttpResponse<List<ExpenseModel>>> getAllExpense();

  @POST('expenses')
  Future<HttpResponse<ExpenseModel>> addExpense(@Body() AddExpenseParams params);

  @PUT("expenses/{id}")
  Future<HttpResponse<String>> updateExpense(@Path() String id , @Body() AddExpenseParams params);

  @DELETE("expenses/{id}")
  Future<HttpResponse<List<ExpenseModel>>> deleteExpense(@Path() String id);

}