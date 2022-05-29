import 'package:my_flutter/src/core/params/add_expense_params.dart';
import 'package:my_flutter/src/core/resources/data_state.dart';
import 'package:my_flutter/src/core/usecases/usecase.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';

import '../repositories/expenses_repository.dart';

class AddExpenseUseCase implements UseCase<DataState<Expense>, AddExpenseParams> {

  final ExpensesRepository _expensesRepository;

  AddExpenseUseCase(this._expensesRepository);

  @override
  Future<DataState<Expense>> call({ AddExpenseParams? params}) {
    return _expensesRepository.addExpense(params!);
  }

}