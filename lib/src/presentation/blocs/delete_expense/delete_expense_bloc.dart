import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:my_flutter/src/core/resources/data_state.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';

import '../../../core/bloc/bloc_with_state.dart';
import '../../../domain/usecases/delete_expense_usecase.dart';

part 'delete_expense_event.dart';
part 'delete_expense_state.dart';

class DeleteExpenseBloc
    extends BlocWithState<DeleteExpenseEvent, DeleteExpenseState> {
  final DeleteExpenseUseCase _deleteExpenseUseCase;
  final List<Expense> _expenses = [];

  DeleteExpenseBloc(this._deleteExpenseUseCase)
      : super(const DeleteExpenseError(null)) {
    on<DeleteExpenseEvent>((event, emit) async {
      emit(const DeleteExpenseLoading());
      final dataState = await _deleteExpenseUseCase(params: event.id);
      List<Expense> expenses;
      if (dataState.data != null) {
        expenses = dataState.data!;
      } else {
        expenses = [];
      }

      if (dataState is DataSuccess &&  expenses.isNotEmpty) {
        _expenses.addAll(expenses);
        emit(DeleteExpenseDone(_expenses));
      }else if (dataState is DataFailed && dataState.error != null) {
        emit(DeleteExpenseError(dataState.error!));
      }

    });
  }
}
