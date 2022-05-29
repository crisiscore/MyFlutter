import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:my_flutter/src/core/resources/data_state.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';
import 'package:my_flutter/src/domain/usecases/get_expenses_usecase.dart';

import '../../../core/bloc/bloc_with_state.dart';

part 'remote_expenses_event.dart';
part 'remote_expenses_state.dart';

class RemoteExpensesBloc
    extends BlocWithState<RemoteExpensesEvent, RemoteExpensesState> {
  final GetExpensesUseCase _getExpensesUseCase;
  final List<Expense> _expenses = [];

  RemoteExpensesBloc(this._getExpensesUseCase)
      : super(const RemoteExpensesLoading()) {
    on<RemoteExpensesEvent>((event, emit) async {
      final dataState = await _getExpensesUseCase();
      List<Expense> expenses;
      if (dataState.data != null) {
        expenses = dataState.data!;
      } else {
        expenses = [];
      }

      if (dataState is DataSuccess && expenses.isNotEmpty) {
        const noMoreData = true;
        _expenses.addAll(expenses);
        emit(RemoteExpensesDone(_expenses, noMoreData: noMoreData));
      }
      if (dataState is DataFailed) {
        emit(RemoteExpensesError(dataState.error!));
      }
    });

  }
}
