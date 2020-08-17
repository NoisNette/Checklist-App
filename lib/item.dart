class Item {
  Item(this.body);

  String body;
  bool done = false;

  Item.fromMap(Map map) {
    this.body = map['body'];
    this.done = map['done'];
  }

  Map toMap() {
    return {
      'body': this.body,
      'done': this.done,
    };
  }
}
