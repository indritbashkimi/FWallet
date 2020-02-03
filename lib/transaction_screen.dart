import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallet/data/repository.dart';
import 'package:wallet/transaction_creator_screen.dart';

import 'data/extensions.dart';
import 'domain/transaction.dart';

class TransactionScreen extends StatelessWidget {
  // Declare a field that holds the Todo
  final MyTransaction transaction;

  // In the constructor, require a Todo
  TransactionScreen({Key key, @required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction details"),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Repository().delete(transaction.uid);
              Navigator.of(context).pop();
            },
          ),
          // action button
          // overflow menu
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: new StreamBuilder(
              stream: Firestore.instance
                  .collection('transactions')
                  .document(transaction.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }

                var transaction = Utils.toTransaction(snapshot.data);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Amount", style: Theme.of(context).textTheme.subtitle),
                    Text(transaction.amount.toString(),
                        style: Theme.of(context).textTheme.title),
                    SizedBox(height: 16),
                    Text("Description",
                        style: Theme.of(context).textTheme.subtitle),
                    Text(transaction.description,
                        style: Theme.of(context).textTheme.title),
                    SizedBox(height: 16),
                    Text("Notes", style: Theme.of(context).textTheme.subtitle),
                    Text(transaction.notes ?? "",
                        style: Theme.of(context).textTheme.title),
                    SizedBox(height: 16),
                    Text("Time", style: Theme.of(context).textTheme.subtitle),
                    Text(transaction.time.toString(),
                        style: Theme.of(context).textTheme.title),
                  ],
                );
              })),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TransactionCreatorScreen(
                        transaction: transaction,
                      )));
        },
        label: Text("Edit"),
        icon: Icon(
          Icons.save,
        ),
      ),
    );
  }
}
