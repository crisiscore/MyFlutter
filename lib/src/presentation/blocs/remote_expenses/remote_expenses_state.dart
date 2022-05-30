part of 'remote_expenses_bloc.dart';

abstract class RemoteExpensesState extends Equatable {
  const RemoteExpensesState();

  @override
  List<Object?> get props => [];
}

class RemoteExpensesLoading extends RemoteExpensesState {
  const RemoteExpensesLoading();
}

class RemoteExpensesDone extends RemoteExpensesState {
  final List<Expense>? expenses;

  const RemoteExpensesDone(this.expenses);

  @override
  List<Object?> get props => [expenses];
}

class RemoteExpensesError extends RemoteExpensesState {
  final DioError? error;

  const RemoteExpensesError(this.error);
}

class AddExpenseLoading extends RemoteExpensesState {
  const AddExpenseLoading();
}

class AddExpenseDone extends RemoteExpensesState {
  final Expense? expenses;

  const AddExpenseDone(this.expenses);

  @override
  List<Object?> get props => [expenses];
}

class AddExpenseError extends RemoteExpensesState {
  final DioError ? error;

  const AddExpenseError(this.error);

  @override
  List<Object?> get props => [error];

}

class DeleteExpenseLoading extends RemoteExpensesState {
  const DeleteExpenseLoading();
}

class DeleteExpenseDone extends RemoteExpensesState {

  final List<Expense>? expenses;

  const DeleteExpenseDone(this.expenses);

  @override
  List<Object?> get props => [expenses];
}

class DeleteExpenseError extends RemoteExpensesState {
  final DioError ? error;

  const DeleteExpenseError(this.error);

  @override
  List<Object?> get props => [error];
}

