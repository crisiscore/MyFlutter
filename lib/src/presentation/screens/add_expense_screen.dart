import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter/src/core/params/add_expense_params.dart';
import 'package:my_flutter/src/presentation/blocs/remote_expenses/remote_expenses_bloc.dart';

import '../../domain/entities/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  final Expense? expense;

  const AddExpenseScreen({Key? key, required this.expense}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _amountValidate = false;
  bool _descriptionValidate = false;
  Expense? mExpense;

  @override
  void initState() {
    super.initState();
    mExpense = widget.expense;
    _amountController.text = widget.expense?.amount.toString() ?? '';
    _descriptionController.text = widget.expense?.description.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(mExpense == null ? "Add New Expense" : 'Edit Expense'),
      ),
      body: _buildBlocState(),
    );
  }

  Widget _buildBlocState() {
    return BlocListener<RemoteExpensesBloc, RemoteExpensesState>(
      listener: (context , state){
        if (state is AddExpenseDone) {
          _onSuccess();
        }
      },
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
            controller: _amountController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                labelText: 'Amount',
                errorText: _amountValidate ? 'Amount is empty' : null),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                labelText: "Description",
                errorText:
                    _descriptionValidate ? 'Description is empty' : null),
            keyboardType: TextInputType.multiline,
            minLines: 3,
            maxLines: null,
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(16)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(24))))),
              onPressed: () {
                _onTapSave();
                setState(() {
                  _amountController.text.isEmpty
                      ? _amountValidate = true
                      : _amountValidate = false;
                  _descriptionController.text.isEmpty
                      ? _descriptionValidate = true
                      : _descriptionValidate = false;
                });
              },
              child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  )))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Success!"),
    ));
    Navigator.pop(context , true);
  }

  void _onTapSave() {
    String? id = mExpense != null ? mExpense!.id : null;
    String amount = _amountController.text.toString();
    String description = _descriptionController.text.toString();
    if (amount.isNotEmpty && description.isNotEmpty) {
      AddExpenseParams params = AddExpenseParams(
          id: id, amount: int.parse(amount), description: description);
      BlocProvider.of<RemoteExpensesBloc>(context).add(AddNewExpense(params));
    }
  }
}
