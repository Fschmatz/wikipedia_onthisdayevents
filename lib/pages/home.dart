import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:wikipedia_onthisdayevents/classes/event.dart';
import 'package:wikipedia_onthisdayevents/classes/feed.dart';
import 'package:wikipedia_onthisdayevents/configs/settingsPage.dart';
import 'package:wikipedia_onthisdayevents/widgets/eventTile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //https://en.wikipedia.org/api/rest_v1/#/Feed/onThisDay  -> pg da API

  String day = '';
  String month = '';
  String feedUrl = '';
  List<Event> eventsList = [];
  bool loading = true;
  late DateTime dateSelected;

  @override
  void initState() {
    dateSelected = DateTime.now();
    day = getSelectedDay().toString();
    month = getSelectedMonth().toString();
    feedUrl = 'https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/$month/$day';
    print(feedUrl);
    loadJsonData();
    super.initState();
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
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (data != null) {
      setState(() {
        loading = true;
        dateSelected = data;
        day = getSelectedDay().toString();
        month = getSelectedMonth().toString();
        feedUrl = 'https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/$month/$day';
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
    print('Mes -> ' + getSelectedMonth().toString());
    print('Dia -> ' + getSelectedDay().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Wikipedia On This Day',style: TextStyle(fontSize:19),),
              Text(
                eventsList.length.toString() + " Events",
                style: TextStyle(fontSize:19,color: Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).accentColor,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: loadJsonData,
                  color: Theme.of(context).accentColor,
                  child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: eventsList.length,
                          itemBuilder: (context, index) {
                            return EventTile(
                                text: eventsList[index].toString());
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ]),
                ),
        ),
        floatingActionButton: Container(
          child: FittedBox(
            child: FloatingActionButton.extended(
              backgroundColor: Theme.of(context).accentColor,
              elevation: 0.0,
              onPressed: () {
                chooseDate();
              },
              label: Text(
                day +'/'+ month,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              icon: Icon(
                Icons.event_outlined,
              ),
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
        ));
  }
}
