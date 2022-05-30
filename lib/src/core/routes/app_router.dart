import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';
import 'package:my_flutter/src/injector.dart';
import 'package:my_flutter/src/presentation/blocs/remote_expenses/remote_expenses_bloc.dart';
import 'package:my_flutter/src/presentation/screens/add_expense_screen.dart';
import 'package:my_flutter/src/presentation/screens/bottom_navigation.dart';
import 'package:my_flutter/src/presentation/screens/expenses_screen.dart';

class AppRouter {

  final RemoteExpensesBloc _remoteExpensesBloc = injector();

  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const BottomNavigation());
      case '/addNewExpense':
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

   Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (context) => BlocProvider.value(value: _remoteExpensesBloc , child: view,));
  }

  void dispose() {
    _remoteExpensesBloc.close();
  }
}
