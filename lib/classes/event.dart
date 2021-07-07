class Event {
  final String text;

  Event({required this.text});

  factory Event.fromJSON(dynamic json) {
    return Event(
      text: json['text'],
    );
  }

  @override
  String toString() {
    return '${this.text}';
  }
}
