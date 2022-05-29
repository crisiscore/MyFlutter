part of 'delete_expense_bloc.dart';

abstract class DeleteExpenseState extends Equatable {
  final List<Expense> ? expenses;
  final DioError ? error;

  const DeleteExpenseState({ this.expenses, this.error});

  @override
  List<Object> get props => [expenses!, error!];
}

class DeleteExpenseLoading extends DeleteExpenseState {
  const DeleteExpenseLoading();
}

class DeleteExpenseDone extends DeleteExpenseState {
  const DeleteExpenseDone(List<Expense> expenses)
      : super(expenses: expenses,);
}

class DeleteExpenseError extends DeleteExpenseState {
  const DeleteExpenseError(DioError ? error) : super(error: error);
}