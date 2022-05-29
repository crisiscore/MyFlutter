part of 'delete_expense_bloc.dart';

abstract class DeleteExpenseEvent extends Equatable {

  final String id;

  const DeleteExpenseEvent(this.id);

  @override
  List<Object> get props => [];
}

class DeleteExpense extends DeleteExpenseEvent {
  const DeleteExpense(String id) : super(id);
}