part of 'remote_expenses_bloc.dart';

abstract class RemoteExpensesEvent extends Equatable {
  const RemoteExpensesEvent();

  @override
  List<Object> get props => [];
}

class GetExpenses extends RemoteExpensesEvent {
  const GetExpenses();
}