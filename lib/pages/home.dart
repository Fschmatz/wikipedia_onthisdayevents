import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wikipedia_onthisdayevents/classes/event.dart';
import 'package:wikipedia_onthisdayevents/classes/feed.dart';
import 'package:wikipedia_onthisdayevents/pages/settings/settings.dart';
import 'package:wikipedia_onthisdayevents/widgets/event_tile.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //https://en.wikipedia.org/api/rest_v1/#/Feed/onThisDay  ->  API page

  String day = '';
  String month = '';
  String feedUrl = '';
  List<Event> eventsList = [];
  bool loading = true;
  late DateTime dateSelected;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    dateSelected = DateTime.now();
    day = getSelectedDay().toString();
    month = getSelectedMonth().toString();
    feedUrl = 'https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/$month/$day';
    loadJsonData();
  }

  getSelectedDay() {
    return DateFormat('dd').format(dateSelected);
  }

  getSelectedMonth() {
    return DateFormat('MM').format(dateSelected);
  }

  chooseDate() async {
    DateTime? data = await showDatePicker(
      context: context,
      initialDate: dateSelected,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return child!;
      },
    );

    if (data != null) {
      scrollController.jumpTo(0);
      dateSelected = data;
      day = getSelectedDay().toString();
      month = getSelectedMonth().toString();
      feedUrl = 'https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/$month/$day';

      setState(() {
        loading = true;
      });

      loadJsonData();
    }
  }

  Future<void> loadJsonData() async {
    final response = await http.get(Uri.parse(feedUrl)).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: const Text('Loading Error'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: loadJsonData,
          ),
        ));
      },
    );

    if (response.statusCode == 200) {
      Feed feedList = Feed.fromJson(jsonDecode(response.body));
      List<Event> listEventsFeed = feedList.events.toList();
      eventsList = listEventsFeed;

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar.medium(
              title: Text(Jiffy(dateSelected).format("MMM dd")),
              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.today_outlined,
                    ),
                    onPressed: () {
                      chooseDate();
                    }),
                IconButton(
                    icon: const Icon(
                      Icons.settings_outlined,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Settings(),
                          ));
                    }),
              ],
            ),
          ];
        },
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 450),
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const Divider(
                      height: 0,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: eventsList.length,
                    itemBuilder: (context, index) {

                      Event event = Event(
                        text: eventsList[index].text,
                        eventYear: eventsList[index].eventYear,
                        articleLink: eventsList[index].articleLink,
                        title: eventsList[index].title,
                      );

                      return EventTile(
                        key: UniqueKey(),
                        event: event,
                      );

                    },
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ]),
        ),
      ),
    );
  }
}
