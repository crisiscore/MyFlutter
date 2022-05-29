import 'package:my_flutter/src/core/resources/data_state.dart';
import 'package:my_flutter/src/core/usecases/usecase.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';

import '../repositories/expenses_repository.dart';

class DeleteExpenseUseCase implements UseCase<DataState<List<Expense>>, String> {
  final ExpensesRepository _expensesRepository;

  DeleteExpenseUseCase(this._expensesRepository);

  @override
  Future<DataState<List<Expense>>> call({String? params}) {
    return _expensesRepository.deleteExpense(params!);
  }
}
