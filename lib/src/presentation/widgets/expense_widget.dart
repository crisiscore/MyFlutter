import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter/src/injector.dart';
import 'package:my_flutter/src/presentation/blocs/delete_expense/delete_expense_bloc.dart';

import '../../domain/entities/expense.dart';

class ExpenseWidget extends StatelessWidget {
  final Expense? expense;
  final bool? isRemovable;
  final void Function(Expense article)? onRemove;
  final void Function(Expense article)? onExpensePressed;

  const ExpenseWidget({
    Key? key,
    this.expense,
    this.onExpensePressed,
    this.isRemovable = false,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteExpenseBloc>(
      create: (context) => injector(),
      child: InkWell(
        onTap: _onTap,
        child: Card(
          margin: const EdgeInsets.all(8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense!.description.toString() ?? '',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "${expense!.amount.toString()} MMK" ?? '0 MMK',
                      style: const TextStyle(color: Colors.orange),
                    )
                  ],
                ),
                Center(
                    child: IconButton(
                  onPressed: _onRemove,
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    if (onExpensePressed != null && expense != null) {
      onExpensePressed!(expense!);
    }
  }

  void _onRemove() {
    if (onRemove != null && expense != null) {
      onRemove!(expense!);
    }
  }
}
