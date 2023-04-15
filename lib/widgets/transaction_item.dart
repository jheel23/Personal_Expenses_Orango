import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItems extends StatelessWidget {
  TransactionItems({
    super.key,
    required this.one_transaction,
    required this.deltx,
  });

  final Transaction one_transaction;
  final Function deltx;
  final _bgColor = [
    Colors.blue,
    Colors.orange,
    Colors.amber,
    Colors.red,
    Colors.green
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor[Random().nextInt(4)],
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: FittedBox(
              child: Text('₹${one_transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Opensans',
                    fontSize: 20,
                  )),
            ),
          ),
        ),
        title: Text(
          one_transaction.title,
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        subtitle: Text(
          DateFormat.yMMMMEEEEd().add_jm().format(one_transaction.date),
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        trailing: IconButton(
            onPressed: () => deltx(one_transaction.id),
            icon: Icon(Icons.delete_sweep_outlined,
                color: Theme.of(context).colorScheme.error)),
      ),
    );
  }
}
