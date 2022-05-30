import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter/src/domain/entities/expense.dart';
import 'package:my_flutter/src/injector.dart';
import 'package:my_flutter/src/presentation/screens/add_expense_screen.dart';
import 'package:my_flutter/src/presentation/widgets/expense_widget.dart';

import '../blocs/remote_expenses/remote_expenses_bloc.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
   // context.read<RemoteExpensesBloc>().add(const GetExpenses());
    BlocProvider.of<RemoteExpensesBloc>(context).add(const GetExpenses());
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      body: _buildBlocState(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: _addNewExpense,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBlocState() {
    return BlocListener<RemoteExpensesBloc, RemoteExpensesState>(
      listener: (context, state) {
        print('${state} Bloc State');
        setState(() {});
      },
      child: BlocBuilder<RemoteExpensesBloc, RemoteExpensesState>(
        builder: (context, state) {
          if (state is RemoteExpensesLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is DeleteExpenseLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is RemoteExpensesError) {
            return const Center(
                child: Icon(
              Icons.warning,
              color: Colors.red,
            ));
          }
          if (state is RemoteExpensesDone) {
            if (state.expenses == null) {
              return _buildExpenses([]);
            } else {
              return _buildExpenses(state.expenses!);
            }
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildExpenses(List<Expense> expenses) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        ...List<Widget>.from(
          expenses.map(
            (e) => Builder(
              builder: (context) => ExpenseWidget(
                expense: e,
                onExpensePressed: (e) => _onExpensePressed(e),
                onRemove: (e) => _onRemove(e),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
      ],
    );
  }

  void _onExpensePressed(Expense expense) {
    Navigator.of(context)
        .pushNamed('/addNewExpense' , arguments: expense)
        .then((value)
            {
              BlocProvider.of<RemoteExpensesBloc>(context).add(const GetExpenses());
            });
  }

  void _onRemove(Expense expense) {
    BlocProvider.of<RemoteExpensesBloc>(context).add(DeleteExpense(expense.id!));
  }

  void _addNewExpense() {
    Navigator.of(context)
        .pushNamed('/addNewExpense' , arguments: null)
        .then((value)
            {BlocProvider.of<RemoteExpensesBloc>(context).add(const GetExpenses());});
  }
}
