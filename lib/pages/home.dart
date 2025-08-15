import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wikipedia_onthisdayevents/classes/event.dart';
import 'package:wikipedia_onthisdayevents/classes/feed.dart';
import 'package:wikipedia_onthisdayevents/pages/settings/settings.dart';
import 'package:wikipedia_onthisdayevents/widgets/event_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _day = '';
  String _month = '';

  //String _feedUrl = '';
  List<Event> _eventsList = [];
  bool _loading = true;
  late DateTime _dateSelected;
  final ScrollController _scrollController = ScrollController();

  // https://en.wikipedia.org/api/rest_v1/#/Feed/onThisDay  ->  API page

  @override
  void initState() {
    super.initState();

    _dateSelected = DateTime.now();
    loadJsonData();
  }

  String getSelectedDay() {
    return DateFormat('dd').format(_dateSelected);
  }

  String getSelectedMonth() {
    return DateFormat('MM').format(_dateSelected);
  }

  String getFeedUrl() {
    _day = getSelectedDay().toString();
    _month = getSelectedMonth().toString();

    return 'https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/$_month/$_day';
  }

  chooseDate() async {
    DateTime? data = await showDatePicker(
      context: context,
      initialDate: _dateSelected,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return child!;
      },
    );

    if (data != null) {
      _scrollController.jumpTo(0);
      _dateSelected = data;

      setState(() {
        _loading = true;
      });

      loadJsonData();
    }
  }

  Future<void> loadJsonData() async {
    final response = await http.get(Uri.parse(getFeedUrl())).timeout(
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
      _eventsList = listEventsFeed;

      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar.large(
              title: Text(
                Jiffy(_dateSelected).format("MMMM dd"),
              ),
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
                            builder: (BuildContext context) => const Settings(),
                          ));
                    }),
              ],
            ),
          ];
        },
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 450),
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : ListView(physics: const AlwaysScrollableScrollPhysics(), children: [
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const Divider(
                      height: 0,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _eventsList.length,
                    itemBuilder: (context, index) {
                      Event event = Event(
                        text: _eventsList[index].text,
                        eventYear: _eventsList[index].eventYear,
                        articleLink: _eventsList[index].articleLink,
                        title: _eventsList[index].title,
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
