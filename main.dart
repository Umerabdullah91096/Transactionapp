import 'package:first_app/chart.dart';
import 'package:first_app/newTransaction.dart';
import "package:first_app/transactionList.dart";
import 'package:flutter/material.dart';
import 'transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transaction App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 1,
        title: "sweets",
        date: DateTime.now().subtract(Duration(days: 2)),
        amount: 200),
    Transaction(
        id: 1,
        title: "Bun",
        date: DateTime.now().add(Duration(days: 1)),
        amount: 200),
    Transaction(
        id: 1,
        title: "Chocolate",
        date: DateTime.now().subtract(Duration(days: 1)),
        amount: 200),
    Transaction(
        id: 1,
        title: "Cooler",
        date: DateTime.now().add(Duration(days: 1)),
        amount: 12000),
    Transaction(id: 1, title: "toffee", date: DateTime.now(), amount: 200),
  ];

  void _addNewTransaction(
      String txTitle, double txAmount, BuildContext _context) {
    final newTransaction = new Transaction(
      id: 1,
      title: txTitle,
      amount: txAmount,
      date: new DateTime.now(),
    );
    setState(() {
      _userTransactions.add(newTransaction);
    });
    Navigator.pop(_context);
  }

  void _onAddPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_context) {
        return NewTransaction(
          _addNewTransaction,
          _context,
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction App',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _onAddPressed(context),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Chart(_recentTransactions),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Recent",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              TransactionList(_userTransactions),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onAddPressed(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}