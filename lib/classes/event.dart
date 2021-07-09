class Event {
  final String text;
  int eventYear;
  //String articleLink;
  //String title;

  Event({required this.text,required this.eventYear });

  factory Event.fromJSON(dynamic json) {
    return Event(
      text: json['text'],
      eventYear: json['year'],
      //articleLink: json['title']
    );
  }

  /*@override
  String toString() {
    return '${this.text}';
  }*/
}
