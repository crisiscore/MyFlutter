import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';
import 'package:my_flutter/src/injector.dart';
import 'package:my_flutter/src/presentation/blocs/remote_expenses/remote_expenses_bloc.dart';
import 'package:my_flutter/src/presentation/screens/add_expense_screen.dart';
import 'package:my_flutter/src/presentation/screens/expenses_screen.dart';

class AppRoutes {

  static final RemoteExpensesBloc _remoteExpensesBloc = injector();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const ExpensesScreen());
      case '/AddNewExpense':
        Expense? expense;
        if (settings.arguments != null) {
          expense = settings.arguments as Expense;
        } else {
          expense = null;
        }
        return _materialRoute(AddExpenseScreen(expense: expense));
      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => BlocProvider.value(value: _remoteExpensesBloc , child: view,));
  }
}
