import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter/src/core/resources/data_state.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';
import 'package:my_flutter/src/domain/usecases/delete_expense_usecase.dart';
import 'package:my_flutter/src/domain/usecases/get_expenses_usecase.dart';

import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/params/add_expense_params.dart';
import '../../../domain/usecases/add_expense_usecase.dart';
import '../../../domain/usecases/update_expense_usecase.dart';

part 'remote_expenses_event.dart';

part 'remote_expenses_state.dart';

class RemoteExpensesBloc
    extends BlocWithState<RemoteExpensesEvent, RemoteExpensesState> {
  final GetExpensesUseCase _getExpensesUseCase;
  final AddExpenseUseCase _addExpenseUseCase;
  final UpdateExpenseUseCase _updateExpenseUseCase;
  final DeleteExpenseUseCase _deleteExpenseUseCase;

  final List<Expense> _expenses = [];
  late Expense? _expense;

  RemoteExpensesBloc(this._getExpensesUseCase, this._addExpenseUseCase,
      this._updateExpenseUseCase, this._deleteExpenseUseCase)
      : super(const RemoteExpensesLoading()) {
    on<GetExpenses>((event, emit) async {
      await _onGetExpenses(event, emit);
    });
    on<AddNewExpense>((event, emit) async {
      await _onAddNewExpense(event, emit);
    });
    on<DeleteExpense>((event, emit) async {
     await _onDeleteExpense(event, emit);
    });
  }

  Future<void> _onGetExpenses(
      GetExpenses event, Emitter<RemoteExpensesState> emit) async {
    final dataState = await _getExpensesUseCase();
    List<Expense> expenses;
    if (dataState.data != null) {
      expenses = dataState.data!;
    } else {
      expenses = [];
    }

    if (dataState is DataSuccess) {
      _expenses.clear();
      _expenses.addAll(expenses);
      emit(RemoteExpensesDone(_expenses));
    }
    if (dataState is DataFailed) {
      emit(RemoteExpensesError(dataState.error!));
    }
  }

  Future<void> _onAddNewExpense(
      AddNewExpense event, Emitter<RemoteExpensesState> emit) async {
    if (event.params.id != null) {
      final dataState = await _updateExpenseUseCase(params: event.params);
      String expenses = '';
      if (dataState.data != null) {
        expenses = dataState.data!;
      } else {
        expenses = '';
      }
      if (dataState is DataSuccess) {
        emit(const AddExpenseDone(null));
      } else if (dataState is DataFailed && dataState.error != null) {
        emit(AddExpenseError(dataState.error!));
      }
    } else {
      final dataState = await _addExpenseUseCase(params: event.params);
      _expense = dataState.data;

      if (dataState is DataSuccess && _expense != null) {
        emit(AddExpenseDone(_expense));
      } else if (dataState is DataFailed && dataState.error != null) {
        emit(AddExpenseError(dataState.error!));
      }
    }
  }

  Future<void> _onDeleteExpense(
      DeleteExpense event, Emitter<RemoteExpensesState> emit) async {
    emit(const DeleteExpenseLoading());
    final dataState = await _deleteExpenseUseCase(params: event.id);
    List<Expense> expenses;
    if (dataState.data != null) {
      expenses = dataState.data!;
    } else {
      expenses = [];
    }

    if (dataState is DataSuccess && expenses.isNotEmpty) {
      _expenses.addAll(expenses);
      emit(DeleteExpenseDone(_expenses));
    } else if (dataState is DataFailed && dataState.error != null) {
      emit(DeleteExpenseError(dataState.error!));
    }
  }
}
