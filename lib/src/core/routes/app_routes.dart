import 'package:flutter/material.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';
import 'package:my_flutter/src/presentation/screens/add_expense_screen.dart';
import 'package:my_flutter/src/presentation/screens/expenses_screen.dart';

class AppRoutes {

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
    return MaterialPageRoute(builder: (_) => view);
  }
}
