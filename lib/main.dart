import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //     title: 'New Shoes', id: 't1', date: DateTime.now(), amount: 66.99),
    // Transaction(
    //     title: 'Weekly Groceries',
    //     id: 't2',
    //     date: DateTime.now(),
    //     amount: 66.99),
  ];

   List<Transaction>? get _recentTransaction{
     return _userTransaction.where((tx) {
       return tx.date.isAfter(DateTime.now().subtract(Duration(days:7)));
     }).toList();
   }

  void _addNewTransaction(String txTitle, double txAmount,DateTime? date) {
    final newTx = Transaction(
        title: txTitle,
        id: DateTime.now().toString(),
        date: date==null? DateTime.now():date,
        amount: txAmount);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              child: NewTransaction(_addNewTransaction),
            onTap: (){},
            behavior: HitTestBehavior.opaque,
          );
        });
  }
  void _deleteTransaction(String id)
  {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id==id );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses App'),
        actions: [
          IconButton(
            onPressed: ()=>_startAddNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Chart(_recentTransaction!),
            TransactionList(_userTransaction,_deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
        onPressed: ()=>_startAddNewTransaction(context),
      ),
    );
  }
}
