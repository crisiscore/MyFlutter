part of 'remote_expenses_bloc.dart';

abstract class RemoteExpensesEvent extends Equatable {

  const RemoteExpensesEvent();

  @override
  List<Object> get props => [];

}

class GetExpenses extends RemoteExpensesEvent {
  const GetExpenses();
}

class DeleteExpense extends RemoteExpensesEvent {

  final String id;

  @override
  List<Object> get props => [id];

  const DeleteExpense(this.id);

}

class AddNewExpense extends RemoteExpensesEvent {

  final AddExpenseParams params;

  @override
  List<Object> get props => [params];

  const AddNewExpense(this.params);

}