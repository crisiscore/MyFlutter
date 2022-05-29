import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:my_flutter/src/core/params/add_expense_params.dart';
import 'package:my_flutter/src/core/resources/data_state.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';
import 'package:my_flutter/src/domain/usecases/get_expenses_usecase.dart';

import '../../../core/bloc/bloc_with_state.dart';
import '../../../domain/usecases/add_expense_usecase.dart';
import '../../../domain/usecases/update_expense_usecase.dart';

part 'add_expense_event.dart';

part 'add_expense_state.dart';

class AddExpenseBloc
    extends BlocWithState<AddExpenseEvent, AddExpenseState> {
  final AddExpenseUseCase _addExpenseUseCase;
  final UpdateExpenseUseCase _updateExpenseUseCase;
  late Expense ? _expense;

  AddExpenseBloc(this._addExpenseUseCase , this._updateExpenseUseCase)
      : super(const AddExpenseError(null)) {

    on<AddExpenseEvent>((event, emit) async {
      emit(const AddExpenseLoading());
      if(event.params.id != null){
        final dataState = await _updateExpenseUseCase(params: event.params);
        _expense = null;
        if (dataState is DataSuccess) {
          emit(AddExpenseDone(_expense));
        }else if (dataState is DataFailed && dataState.error != null) {
          emit(AddExpenseError(dataState.error!));
        }
      }else {
        final dataState = await _addExpenseUseCase(params: event.params);
        _expense = dataState.data;

        if (dataState is DataSuccess && _expense != null) {
          emit(AddExpenseDone(_expense!));
        }else if (dataState is DataFailed && dataState.error != null) {
          emit(AddExpenseError(dataState.error!));
        }
      }
    });
  }
}
