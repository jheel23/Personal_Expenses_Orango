//We are using this class to make a customizable LIST

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  Transaction(
      {required this.id,
      required this.date,
      required this.amount,
      required this.title});
}
