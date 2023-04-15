import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double SpendAmount;
  final double Spend_percentage_total;
  const ChartBar(this.label, this.SpendAmount, this.Spend_percentage_total);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            width: 17,
            height: constraints.maxHeight * 0.6,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1.0),
                    color: Color.fromARGB(21, 85, 84, 84),
                    borderRadius: BorderRadius.circular(10)),
              ),
              //this Below box takes height between the height of its parent
              FractionallySizedBox(
                heightFactor: Spend_percentage_total,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ]),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                '₹${SpendAmount.round()}',
                style: TextStyle(
                    fontFamily: 'Opensans',
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      );
    });
  }
}
