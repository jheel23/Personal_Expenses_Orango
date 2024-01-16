import 'package:flutter/material.dart';
import '../widgets/transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> all_transaction;
  final Function deltx;
  TransactionList(this.all_transaction, this.deltx);

  @override
  Widget build(BuildContext context) {
    return all_transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constrainsts) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'No Expenses Yet!',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 35 * MediaQuery.of(context).textScaleFactor),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                      height: constrainsts.maxHeight * 0.6,
                      child: Image.asset('assets/images/no-data.png'))
                ],
              ),
            );
          })
        : ListView(
            children: [
              ...all_transaction
                  .map((item) => TransactionItems(
                        one_transaction: item,
                        deltx: deltx,
                        key: ValueKey(item.id),
                      ))
                  .toList()
            ],
          );
  }
}
