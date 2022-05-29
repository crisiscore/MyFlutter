part of 'remote_expenses_bloc.dart';

abstract class RemoteExpensesState extends Equatable {
  final List<Expense> ? expenses;
  final bool ? noMoreData;
  final DioError ? error;

  const RemoteExpensesState({ this.expenses, this.noMoreData, this.error});

  @override
  List<Object> get props => [expenses!, noMoreData!, error!];
}

class RemoteExpensesLoading extends RemoteExpensesState {
  const RemoteExpensesLoading();
}

class RemoteExpensesDone extends RemoteExpensesState {
  const RemoteExpensesDone(List<Expense> expenses, {bool ? noMoreData})
      : super(expenses: expenses, noMoreData: noMoreData);
}

class RemoteExpensesError extends RemoteExpensesState {
  const RemoteExpensesError(DioError error) : super(error: error);
}