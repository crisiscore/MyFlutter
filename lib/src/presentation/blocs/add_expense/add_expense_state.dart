part of 'add_expense_bloc.dart';

abstract class AddExpenseState extends Equatable {
  final Expense ? expense;
  final DioError ? error;

  const AddExpenseState({ this.expense, this.error});

  @override
  List<Object> get props => [expense!, error!];
}

class AddExpenseLoading extends AddExpenseState {
  const AddExpenseLoading();
}

class AddExpenseDone extends AddExpenseState {
  const AddExpenseDone(Expense ? expense)
      : super(expense: expense,);
}

class AddExpenseError extends AddExpenseState {
  const AddExpenseError(DioError ? error) : super(error: error);
}