class AddExpenseParams {
  final String? id;
  final int? amount;
  final String? description;

  const AddExpenseParams({this.id, this.amount, this.description});

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'description': description,
      };
}
