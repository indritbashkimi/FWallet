import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:wallet/transaction_list.dart';

import 'about_screen.dart';
import 'domain/transaction.dart';
import 'transaction_creator_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _navigateToCreate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransactionCreatorScreen(
              transaction:
                  MyTransaction(uid: null, description: null, amount: 0)),
        ));
  }

  void _navigateToAbout(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AboutScreen()));
  }

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    /*setState(() {
      //_selectedChoice = choice;
    });*/
    switch (choice.id) {
      case 'about':
        _navigateToAbout(context);
        break;
      default:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("TODO"),
                content: Text("Not implemented yet"),
              );
            });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Text(widget.title),
      backLayer: MyThreeOptions(),
      frontLayer:
          Stack(alignment: AlignmentDirectional.bottomEnd, children: <Widget>[
        Center(
          child: TransactionListRoute(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            onPressed: () {
              _navigateToCreate(context);
            },
            tooltip: 'Add',
            child: Icon(
              Icons.add,
            ), // color: Theme.of(context).primaryTextTheme.title.color,
          ),
        ),
      ]),
      iconPosition: BackdropIconPosition.leading,
      actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            /*_select(choices[0]);*/
          },
        ),
        // action button
        // overflow menu
        PopupMenuButton<Choice>(
          onSelected: _select,
          itemBuilder: (BuildContext context) {
            return choices.skip(1).map((Choice choice) {
              return PopupMenuItem<Choice>(
                value: choice,
                child: Text(choice.title),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}

class MyThreeOptions extends StatefulWidget {
  @override
  _MyThreeOptionsState createState() => _MyThreeOptionsState();
}

class _MyThreeOptionsState extends State<MyThreeOptions> {
  int _value = 0;

  final List<String> _filter = <String>[
    'Tutto',
    'Entrate',
    'Uscite',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("To Do"),
        Row(
          children: List<Widget>.generate(
            3,
            (int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChoiceChip(
                  label: Text(_filter[index]),
                  selected: _value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? index : null;
                    });
                  },
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

class FilterEntry {
  const FilterEntry(this.title, this.id);

  final String title;
  final String id;
}

class Choice {
  const Choice({this.id, this.title, this.icon});

  final String id;
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(id: 'search', title: 'Search', icon: Icons.search),
  const Choice(id: 'settings', title: 'Settings', icon: Icons.settings),
  const Choice(id: 'about', title: 'About', icon: Icons.info),
];
