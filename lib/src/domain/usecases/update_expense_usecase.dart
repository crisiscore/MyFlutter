import '../../core/params/add_expense_params.dart';
import '../../core/resources/data_state.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/expenses_repository.dart';

class UpdateExpenseUseCase implements UseCase<DataState<String>, AddExpenseParams> {

  final ExpensesRepository _expensesRepository;

  UpdateExpenseUseCase(this._expensesRepository);

  @override
  Future<DataState<String>> call({AddExpenseParams? params}) {
    return _expensesRepository.updateExpense(params!.id! , params);
  }

}