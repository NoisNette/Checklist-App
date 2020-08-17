import 'dart:convert';

import 'package:checklist_app/itemList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'textInputWidget.dart';
import 'item.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = [];
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    loadSharedPreferencesAndData();
  }

  void newItem(String text) {
    if (text != '') {
      this.setState(() {
        items.add(new Item(text));
        saveData();
      });
    }
  }

  void loadSharedPreferencesAndData() async {
    prefs = await SharedPreferences.getInstance();
    loadData();
  }

  void loadData() {
    List<String> listString = prefs.getStringList('list');
    if (listString != null) {
      items = listString
          .map(
            (item) => Item.fromMap(
              json.decode(item),
            ),
          )
          .toList();
      setState(() {});
    }
  }

  void saveData() {
    List<String> listString = items
        .map(
          (item) => json.encode(
            item.toMap(),
          ),
        )
        .toList();
    prefs.setStringList('list', listString);
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
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              setState(() {
                this.items.clear();
                saveData();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: ItemList(this.items, saveData)),
          Divider(thickness: 1, height: 0, color: Colors.grey),
          TextInputWidget(this.newItem),
        ],
      ),
    );
  }
}
