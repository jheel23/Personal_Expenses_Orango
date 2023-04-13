import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> all_transaction;
  final Function deltx;
  TransactionList(this.all_transaction, this.deltx);

  @override
  Widget build(BuildContext context) {
    return all_transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constrainsts) {
            return Column(
              children: [
                Text(
                  'No Expenses Yet!',
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 35 * MediaQuery.of(context).textScaleFactor),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                    height: constrainsts.maxHeight * 0.6,
                    child: Image.asset('assets/images/no-data.png'))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: FittedBox(
                        child: Text(
                            '₹${all_transaction[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Opensans',
                              fontSize: 20,
                            )),
                      ),
                    ),
                  ),
                  title: Text(
                    all_transaction[index].title,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMEEEEd()
                        .add_jm()
                        .format(all_transaction[index].date),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  trailing: IconButton(
                      onPressed: () => deltx(all_transaction[index].id),
                      icon: Icon(Icons.delete_sweep_outlined,
                          color: Theme.of(context).colorScheme.error)),
                ),
              );
            },
            itemCount: all_transaction.length,
          );
  }
}
