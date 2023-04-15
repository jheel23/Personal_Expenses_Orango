import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;
  NewTransaction(this.addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredtitle = _titleController.text;
    final enteredamount = double.parse(_amountController.text);
    if (enteredtitle.isEmpty || enteredamount <= 0 || _selectedDate == null) {
      return; //it'll terminate the code here if condition is true or one of the field is not filled
    }
    widget.addtx(enteredtitle, enteredamount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    /*Show Date Picker Feature in flutter returns a future value so we use "then" keyword given in flutter
    We use this keyword to get the value when user gives it*/
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        _selectedDate = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Container(
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.fromLTRB(
              10, 0, 0, MediaQuery.of(context).viewInsets.bottom + 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                // onChanged: (value) => titleinput = value,
                controller: _titleController,
                cursorColor: Theme.of(context).primaryColorDark,
                cursorHeight: 30,
                onSubmitted: (_) => _submitData(),
                spellCheckConfiguration: SpellCheckConfiguration(),
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                    )),
              ),
              TextField(
                //onChanged: (value) => amountinput = value,
                controller: _amountController,
                cursorColor: Theme.of(context).primaryColorDark,
                cursorHeight: 30,
                onSubmitted: (_) => _submitData(),
                keyboardType: TextInputType
                    .number, //for IOS: TextInputTypeWithOptions(decimal:true)
                decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                    )),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Chosen Date'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                  ),
                  TextButton(
                      onPressed: _datePicker,
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              ElevatedButton(
                  onPressed: _submitData,
                  child: const Text(
                    'Add Transaction',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.white))),
            ],
          ),
        ),
        elevation: 5,
      ),
    );
  }
}
