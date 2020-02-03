import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallet/domain/transaction.dart';

extension DocumentParsing on DocumentSnapshot {
  MyTransaction toTransaction() {
    DocumentSnapshot document = this;
    return new MyTransaction(
        uid: document.documentID,
        description: document['description'],
        amount: document['amount'],
        time: DateTime.parse(document['time']),
        notes: document['notes']);
  }
}

class Utils {
  static MyTransaction toTransaction(DocumentSnapshot document) {
    return document.toTransaction();
  }
}
