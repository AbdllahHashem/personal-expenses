import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData()
  {
    final enteredAmount=double.parse(amountController.text);
    final enteredTitle=titleController.text;

    if(enteredTitle.isEmpty|| enteredAmount<0)
      {
        return;
      }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker()
  {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate:  DateTime(2021),
        lastDate:  DateTime.now()).then((pickedDate) {
          if(pickedDate==null)
            return;
          setState(() {
            _selectedDate=pickedDate;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_)=>_submitData,
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
              onSubmitted: (_)=>_submitData,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate==null? 'No Date Chosen! ' : 'Picked Date : ${DateFormat().add_yMd().format( _selectedDate!) }'
                    ),
                  ),
                  TextButton(onPressed: _presentDatePicker, child: Text(
                    'Choose Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),)

                ],
              ),
            ),
            MaterialButton(
              onPressed: _submitData,
              color: Theme.of(context).primaryColor,
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
      ),
      elevation: 5,
    );
  }
}
