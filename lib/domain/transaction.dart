import 'package:meta/meta.dart';

import 'tag.dart';

class MyTransaction {
  final String uid;
  final String description;
  final double amount;
  final DateTime time;
  final String notes;
  final List<Tag> tags;

  const MyTransaction(
      {@required this.uid,
      @required this.description,
      @required this.amount,
      this.time,
      this.notes,
      this.tags})
      : assert(amount != null);
}
