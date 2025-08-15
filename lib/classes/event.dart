import 'package:dynamic_value/dynamic_value.dart';

class Event {
  final String text;
  final int eventYear;
  final String title;
  final String articleLink;

  Event({required this.text, required this.eventYear, required this.title, required this.articleLink});

  factory Event.fromJSON(dynamic json) {
    final value = DynamicValue(json);

    return Event(
      text: json['text'],
      eventYear: json['year'],
      title: value['pages'][0]['titles']['normalized'].toString(),
      articleLink: value['pages'][0]['content_urls']['desktop']['page'].toString(),
    );
  }
}
