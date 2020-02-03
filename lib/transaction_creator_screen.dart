import 'package:flutter/material.dart';

import 'data/repository.dart';
import 'domain/transaction.dart';

class TransactionCreatorScreen extends StatelessWidget {
  const TransactionCreatorScreen({Key key, this.transaction}) : super(key: key);

  final MyTransaction transaction;

  @override
  Widget build(BuildContext context) {
    String title;
    if (transaction.uid == null)
      title = "Create new transaction";
    else
      title = "Edit transaction";
    MyCustomForm form = new MyCustomForm(
      transaction: transaction,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: form,
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key key, this.transaction}) : super(key: key);

  final MyTransaction transaction;

  @override
  _MyCustomFormState createState() => _MyCustomFormState(transaction);
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  _MyCustomFormState(MyTransaction transaction) {
    this.transaction = transaction;
  }

  MyTransaction transaction;

  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final notesController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    amountController.dispose();
    descriptionController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    amountController.text = transaction.amount.toString();
    descriptionController.text = transaction.description;
    notesController.text = transaction.notes;

    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.attach_money),
                    hintText: '0',
                    labelText: 'Amount',
                  ),
                  onSaved: (String value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter amount';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.title),
                    labelText: 'Description',
                  ),
                  onSaved: (String value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: notesController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.note_add),
                    labelText: 'Notes',
                  ),
                  onSaved: (String value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter notes';
                    }
                    return null;
                  },
                ),
              ],
            )),
        FloatingActionButton.extended(
          heroTag: "save_transaction",
          onPressed: () {
            MyTransaction newTransaction = MyTransaction(
              uid: transaction.uid,
              amount: double.tryParse(amountController.value.text) ?? 0,
              description: descriptionController.value.text,
              notes: notesController.value.text,
              time: DateTime.now(),
              tags: null,
            );
            new Repository().submit(newTransaction);
            Navigator.of(context).pop();
          },
          tooltip: 'Save',
          label: Text("Save"),
          icon: Icon(
            Icons.save,
          ),
        ),
      ],
    );
  }
}
