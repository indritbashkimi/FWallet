import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'domain/transaction.dart';
import 'transaction_screen.dart';
import 'data/extensions.dart';

class TransactionListRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransactionListRouteState();
}

class _TransactionListRouteState extends State<TransactionListRoute> {
  var inColor = Colors.green;
  var outColor = Colors.redAccent;
  DateFormat formatter = new DateFormat.yMMMMd();

  void _navigateToItem(BuildContext context, MyTransaction transaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionScreen(transaction: transaction),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection("transactions").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text("Loading...");
          if (snapshot.hasError)
            return const Text(
                "Cannot load content. Check your internet connection.");
          if (snapshot.data.documents.length == 0)
            return const Text("No items. Start adding one :)");
          return ListView.separated(
              itemCount: snapshot.data.documents.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                    height: 1,
                  ),
              itemBuilder: (context, index) {
                MyTransaction transaction = Utils.toTransaction(snapshot.data.documents[index]);
                return _buildListItem(context, transaction);
              });
        });
  }

  Widget _buildListItem(BuildContext context, MyTransaction transaction) {
    return Container(
      child: InkWell(
        onTap: () {
          _navigateToItem(context, transaction);
          /*Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Tap'),
                ));*/
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${transaction.description}',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    transaction.notes ?? "",
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '${transaction.amount} €',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.display1.copyWith(
                          color: transaction.amount < 0 ? outColor : inColor),
                    ),
                    Text(
                      formatter.format(transaction.time),
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
