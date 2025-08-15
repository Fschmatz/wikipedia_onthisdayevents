import 'package:wikipedia_onthisdayevents/classes/event.dart';

class Feed {
  List<Event> events;

  Feed(this.events);

  factory Feed.fromJson(dynamic json) {
    if (json['events'] != null) {
      var eventsObjsJson = json['events'] as List;
      List<Event> eventsList = eventsObjsJson.map((eventJson) => Event.fromJSON(eventJson)).toList();

      return Feed(
        eventsList,
      );
    }
    throw {print('Feed Error')};
  }
}
