import 'package:my_flutter/src/core/resources/data_state.dart';
import 'package:my_flutter/src/core/usecases/usecase.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';
import 'package:my_flutter/src/domain/repositories/expenses_repository.dart';

class GetExpensesUseCase implements UseCase<DataState<List<Expense>>, String> {

  final ExpensesRepository _expensesRepository;

  GetExpensesUseCase(this._expensesRepository);

  @override
  Future<DataState<List<Expense>>> call({String? params}) {
    return _expensesRepository.getAllExpenses();
  }

}