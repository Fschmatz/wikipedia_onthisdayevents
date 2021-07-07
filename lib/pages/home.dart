import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:webfeed/webfeed.dart';
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

  static const String feedUrl = 'https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/07/05';
  List<Event> eventsList = [];
  bool loading = false;

  @override
  void initState() {
    loadJsonData();
    super.initState();
  }


  Future<void> loadJsonData() async {
    final response = await http.get(Uri.parse(feedUrl));
    if (response.statusCode == 200) {
      Feed feedList = Feed.fromJson(jsonDecode(response.body));

      List<Event> listaEvents = feedList.events.toList();

      setState(() {
        //loading = false;
       eventsList = listaEvents;
      });

      print(eventsList.length);
    }

    /*final events = responses.((response) {
      final json = jsonDecode(response.body);
      return Feed.fromJSON(json);
    }).toList();*/
    /*setState(() {
      loading = false;
      eventsList = events.map((ev) => null);
    });*/

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Wikipedia On This Day'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: Theme.of(context)
                    .textTheme
                    .headline6!
                    .color!
                    .withOpacity(0.7),
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
                      ListTile(
                        //DEPOIS VIRA BOTÃO
                        leading: Icon(Icons.calendar_today_outlined),
                        title: Text('05/07'),
                        trailing: Text('Events '+ eventsList.length.toString()),
                        onTap: (){},
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: eventsList.length,
                        itemBuilder: (context, index) {
                          return EventTile(text: eventsList[index].toString());

                        },
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ]),
              ),
      ),

    );
  }
}
