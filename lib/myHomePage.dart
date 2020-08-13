import 'package:checklist_app/itemList.dart';
import 'package:flutter/material.dart';
import 'textInputWidget.dart';
import 'item.dart';
import 'itemList.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = [];

  void newItem(String text) {
    if (text != '') {
      this.setState(() {
        items.add(new Item(text));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Tooltip(
          message: 'Checklist App',
          child: Text('Checklist App'),
        ),
        actions: <Widget>[
          Tooltip(
            message: 'Clear items',
            child: IconButton(
                icon: Icon(Icons.restore),
                onPressed: () {
                  setState(() {
                    this.items.clear();
                  });
                }),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ItemList(this.items),
          ),
          Divider(thickness: 1, height: 0, color: Colors.grey),
          TextInputWidget(this.newItem),
        ],
      ),
    );
  }
}
