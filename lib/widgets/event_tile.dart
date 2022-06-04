import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wikipedia_onthisdayevents/classes/event.dart';

class EventTile extends StatefulWidget {
  @override
  _EventTileState createState() => _EventTileState();

  Event event;

  EventTile({Key? key, required this.event}) : super(key: key);
}

class _EventTileState extends State<EventTile> {
  //URL LAUNCHER
  _launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.event.articleLink != 'null') {
          _launchBrowser(widget.event.articleLink);
        }
      },
      onLongPress: () {
        if (widget.event.title != 'null') {
          Share.share(widget.event.articleLink);
        }
      },
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            title: Text(
              widget.event.text,
            ),
          ),
          ListTile(
            title: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: widget.event.eventYear.toString(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.w400),
                ),
                const TextSpan(
                  text: '      ',
                ),
                TextSpan(
                  text: widget.event.title == 'null' ? ' ' : widget.event.title,
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context)
                          .textTheme
                          .headline6!
                          .color!
                          .withOpacity(0.7),
                      fontWeight: FontWeight.w400),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}

