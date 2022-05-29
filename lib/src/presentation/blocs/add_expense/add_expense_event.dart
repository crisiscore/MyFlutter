part of 'add_expense_bloc.dart';

abstract class AddExpenseEvent extends Equatable {

  final AddExpenseParams params;

  const AddExpenseEvent(this.params);

  @override
  List<Object> get props => [];
}

class AddNewExpense extends AddExpenseEvent {
  const AddNewExpense(AddExpenseParams params) : super(params);
}