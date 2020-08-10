import 'package:flutter/material.dart';
import 'item.dart';

class ItemList extends StatefulWidget {
  ItemList(this.listItems);

  final List<Item> listItems;

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.widget.listItems.length,
        itemBuilder: (context, index) {
          var item = this.widget.listItems[index];
          return Card(
            child: CheckboxListTile(
              value: item.done,
              onChanged: (bool value) {
                setState(() {
                  item.done = value;
                });
              },
              title: Text(item.body,
                  style: TextStyle(
                      color: item.done ? Colors.grey : Colors.black,
                      decoration:
                          item.done ? TextDecoration.lineThrough : null)),
            ),
          );
        });
  }
}
