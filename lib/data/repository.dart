import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:wallet/domain/transaction.dart';

class Repository with ChangeNotifier {
  Stream<MyTransaction> get transactions {
    Stream<MyTransaction> dataStream() async* {
      Stream<QuerySnapshot> source =
          Firestore.instance.collection("transactions").snapshots();
      await for (var snapshot in source) {
        for (var i = 0; i < snapshot.documents.length; i++) {
          var document = snapshot.documents[i];
          var transaction = new MyTransaction(
              uid: document.documentID,
              description: document['description'],
              amount: document['amount']);
          yield transaction;
        }
      }
    }

    return dataStream();
  }

  Future<bool> submit(MyTransaction transaction) async {
    var db = Firestore.instance;
    Map<String, dynamic> data = {
      'amount': transaction.amount,
      'description': transaction.description,
      "notes": transaction.notes,
      "time": transaction.time.toIso8601String()
    };
    DocumentReference reference;
    if (transaction.uid != null) {
      reference = db.collection("transactions").document(transaction.uid);
    } else {
      reference = db.collection("transactions").document();
    }
    reference.setData(data).catchError((e) {
      print("error $e");
      return false;
    }).whenComplete(() {
      print("transaction saved maybe");
    }).then((documentReference) {
      print("transaction certenly saved?");
    });
    return true;
  }

  void get(String transactionId) {
    Firestore.instance.collection("transactions").document(transactionId).snapshots();
  }

  Future<bool> delete(String transactionId) async {
    var db = Firestore.instance;
    db.collection("transactions").document(transactionId).delete().catchError((e) {
      print("error $e");
      return false;
    }).whenComplete(() {
      print("transaction deleted maybe");
    }).then((documentReference) {
      print("transaction certenly deleted?");
    });
    return true;
  }
}
