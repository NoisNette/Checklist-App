import 'package:flutter/material.dart';
import 'item.dart';

class ItemList extends StatefulWidget {
  ItemList(this._listItems, this.saveData);

  final Function saveData;

  final List<Item> _listItems;

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  Future<bool> _promptUser() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete?'),
            actions: [
              FlatButton(
                child: Text('Yes'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          ),
          barrierDismissible: true,
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget._listItems.length,
      itemBuilder: (context, index) {
        var item = this.widget._listItems[index];
        return Dismissible(
          key: ValueKey(item),
          onDismissed: (direction) {
            setState(() {
              this.widget._listItems.removeAt(index);
              widget.saveData();
            });
          },
          background: Card(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          confirmDismiss: (direction) => _promptUser(),
          direction: DismissDirection.horizontal,
          child: Card(
            child: CheckboxListTile(
              value: item.done,
              onChanged: (bool value) {
                setState(() {
                  item.done = value;
                  widget.saveData();
                });
              },
              title: Text(
                item.body,
                style: TextStyle(
                    color: item.done ? Colors.grey : Colors.black,
                    decoration: item.done ? TextDecoration.lineThrough : null),
              ),
            ),
          ),
        );
      },
    );
  }
}
