import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  TextInputWidget(this.callback);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();

  final Function(String) callback;
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    widget.callback(controller.text);
    FocusScope.of(context).unfocus();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.done,
      onSubmitted: (value) => this.click(),
      controller: this.controller,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.chat_bubble),
        labelText: 'Enter an item:',
        suffixIcon: IconButton(
            icon: Icon(Icons.add),
            splashColor: Colors.blue,
            tooltip: 'Submit',
            onPressed: this.click),
      ),
    );
  }
}
