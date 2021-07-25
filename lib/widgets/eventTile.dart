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
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 0),
            title: Text(
              widget.event.text,
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(0, 3.5, 0, 0),
              child: Text(
                widget.event.eventYear.toString(),
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).accentTextTheme.headline1!.color,
                    fontWeight: FontWeight.w600),
              ),
            ),
            title: Visibility(
              visible: widget.event.title != 'null',
              child: Text(
                widget.event.title,
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context)
                        .textTheme
                        .headline6!
                        .color!
                        .withOpacity(0.6),
                    fontWeight: FontWeight.w600),
              ),
            ),
            trailing: Visibility(
              visible: widget.event.title != 'null',
              child: IconButton(
                onPressed: () {
                  Share.share(widget.event.articleLink);
                },
                splashRadius: 25,
                icon: Icon(
                  Icons.share_outlined,
                  size: 22,
                  color: Theme.of(context)
                      .textTheme
                      .headline6!
                      .color!
                      .withOpacity(0.6),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
