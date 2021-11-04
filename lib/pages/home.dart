import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:wikipedia_onthisdayevents/classes/event.dart';
import 'package:wikipedia_onthisdayevents/classes/feed.dart';
import 'package:wikipedia_onthisdayevents/configs/settingsPage.dart';
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
  final controllerScroll = ScrollController();
  final ValueNotifier<bool> _showFab = ValueNotifier<bool>(true);

  @override
  void initState() {
    dateSelected = DateTime.now();
    day = getSelectedDay().toString();
    month = getSelectedMonth().toString();
    feedUrl =
        'https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/$month/$day';
    loadJsonData();
    super.initState();

    controllerScroll.addListener(
      () {
        if (controllerScroll.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_showFab.value) {
            _showFab.value = false;
          }
        }

        if (controllerScroll.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!_showFab.value) {
            _showFab.value = true;
          }
        }
      },
    );
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
        lastDate: DateTime(DateTime.now().year + 1));

    if (data != null) {
      setState(() {
        loading = true;
        dateSelected = data;
        day = getSelectedDay().toString();
        month = getSelectedMonth().toString();
        feedUrl =
            'https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/$month/$day';
      });
      loadJsonData();
    }
  }

  Future<void> loadJsonData() async {
    final response = await http.get(Uri.parse(feedUrl));
    if (response.statusCode == 200) {
      Feed feedList = Feed.fromJson(jsonDecode(response.body));
      List<Event> listaEvents = feedList.events.toList();
      setState(() {
        loading = false;
        eventsList = listaEvents;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
    controller: controllerScroll,
    title: const Text('Wikipedia Day Events'),
    actions: [
      IconButton(
          color: Theme.of(context)
              .textTheme
              .headline6!
              .color!
              .withOpacity(0.8),
          icon: const Icon(
            Icons.settings_outlined,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SettingsPage(),
                  fullscreenDialog: true,
                ));
          }),
    ],
      ),
      body: AnimatedSwitcher(
    duration: const Duration(milliseconds: 600),
    child: loading
        ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).accentColor,
            ),
          )
        : ListView(
            controller: controllerScroll,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: eventsList.length,
                  itemBuilder: (context, index) {
                    return EventTile(
                      key: UniqueKey(),
                      event: Event(
                        text: eventsList[index].text,
                        eventYear: eventsList[index].eventYear,
                        articleLink: eventsList[index].articleLink,
                        title: eventsList[index].title,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 50,
                )
              ]),
      ),
      floatingActionButton: ValueListenableBuilder(
    valueListenable: _showFab,
    builder: (context, bool value, child) => AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: _showFab.value ? 1 : 0,
      child: FloatingActionButton.extended(
        onPressed: () {
          chooseDate();
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        label: Text(
          day + '/' + month,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15),
        ),
        icon: const Icon(
          Icons.today,
        ),
      ),
    ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
    );
  }
}
