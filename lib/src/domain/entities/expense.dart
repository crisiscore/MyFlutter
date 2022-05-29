import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final String? id;
  final int amount;
  final String description;

  const Expense({this.id, required this.amount, required this.description});

  @override
  List<Object?> get props {
    return [id, amount, description];
  }
}
