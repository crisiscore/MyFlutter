import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_flutter/src/data/datasources/remote/expense_api_service.dart';
import 'package:my_flutter/src/data/repositories/expense_repository_impl.dart';
import 'package:my_flutter/src/domain/usecases/add_expense_usecase.dart';
import 'package:my_flutter/src/domain/usecases/get_expenses_usecase.dart';
import 'package:my_flutter/src/domain/usecases/update_expense_usecase.dart';
import 'package:my_flutter/src/presentation/blocs/add_expense/add_expense_bloc.dart';
import 'package:my_flutter/src/presentation/blocs/delete_expense/delete_expense_bloc.dart';
import 'package:my_flutter/src/presentation/blocs/remote_expenses/remote_expenses_bloc.dart';

import 'domain/repositories/expenses_repository.dart';
import 'domain/usecases/delete_expense_usecase.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio client
  injector.registerSingleton<Dio>(Dio());

  // Dependencies
  injector.registerSingleton<ExpenseAPIService>(ExpenseAPIService(injector()));

  // *
  injector.registerSingleton<ExpensesRepository>(
    ExpenseRepositoryImpl(injector()),
  );

  // UseCases
  injector
      .registerSingleton<GetExpensesUseCase>(GetExpensesUseCase(injector()));
  injector.registerSingleton<AddExpenseUseCase>(AddExpenseUseCase(injector()));
  injector.registerSingleton<UpdateExpenseUseCase>(UpdateExpenseUseCase(injector()));
  injector.registerSingleton<DeleteExpenseUseCase>(
      DeleteExpenseUseCase(injector()));

  // Blocs
  injector.registerFactory<RemoteExpensesBloc>(
    () => RemoteExpensesBloc(injector()),
  );

  injector.registerFactory<AddExpenseBloc>(
    () => AddExpenseBloc(injector(), injector()),
  );

  injector.registerFactory<DeleteExpenseBloc>(
        () => DeleteExpenseBloc(injector()),
  );
}
