import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:wikipedia_onthisdayevents/classes/event.dart';
import 'package:wikipedia_onthisdayevents/classes/feed.dart';
import 'package:wikipedia_onthisdayevents/configs/settingsPage.dart';
import 'package:wikipedia_onthisdayevents/widgets/eventTile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  //https://en.wikipedia.org/api/rest_v1/#/Feed/onThisDay  ->  API page

  String day = '';
  String month = '';
  String feedUrl = '';
  List<Event> eventsList = [];
  bool loading = true;
  late DateTime dateSelected;
  final controllerScroll = ScrollController();

  @override
  void initState() {
    dateSelected = DateTime.now();
    day = getSelectedDay().toString();
    month = getSelectedMonth().toString();
    feedUrl =
        'https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/$month/$day';
    loadJsonData();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

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
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
            appBar: ScrollAppBar(
              elevation: 0,
              controller: controllerScroll,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Wikipedia On This Day'),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 600),
                    child: loading
                        ? SizedBox.shrink()
                        : Text(
                            eventsList.length.toString() + " Events",
                            style: TextStyle(color: Theme.of(context).hintColor),
                          ),
                  ),
                ],
              ),
            ),
            body: AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  : ListView(
                      controller: controllerScroll,
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                          ListView.separated(
                            separatorBuilder: (BuildContext context, int index) =>
                                const Divider(
                              height: 0,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: eventsList.length,
                            itemBuilder: (context, index) {
                              return EventTile(
                                event: new Event(
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
            floatingActionButton: Container(
              child: FloatingActionButton.extended(
                elevation: 0.0,
                onPressed: () {
                  chooseDate();
                },
                label: Text(
                  day + '/' + month,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                icon: Icon(
                  Icons.today,
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                    IconButton(
                        color: Theme.of(context)
                            .textTheme
                            .headline6!
                            .color!
                            .withOpacity(0.8),
                        icon: Icon(
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
                  ])),
            )),
      ),
    );
  }
}
