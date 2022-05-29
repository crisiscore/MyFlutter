import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';
import 'package:my_flutter/src/injector.dart';
import 'package:my_flutter/src/presentation/blocs/add_expense/add_expense_bloc.dart';
import 'package:my_flutter/src/presentation/screens/add_expense_screen.dart';
import 'package:my_flutter/src/presentation/screens/expenses_screen.dart';

import '../../presentation/blocs/delete_expense/delete_expense_bloc.dart';

class AppRoutes {
  static final AddExpenseBloc _addExpenseBloc = injector();
  static final DeleteExpenseBloc _deleteExpenseBloc = injector();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) => BlocProvider.value(
                value: _deleteExpenseBloc, child: const ExpensesScreen()));
      case '/AddNewExpense':
        Expense? expense;
        if (settings.arguments != null) {
          expense = settings.arguments as Expense;
        } else {
          expense = null;
        }
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) => BlocProvider.value(
                value: _addExpenseBloc,
                child: AddExpenseScreen(expense: expense)));
      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  void dispose() {
    _addExpenseBloc.close();
  }
}
