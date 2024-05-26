import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wikipedia_onthisdayevents/classes/event.dart';

import '../util/utils.dart';

class EventTile extends StatefulWidget {
  @override
  _EventTileState createState() => _EventTileState();

  Event event;

  EventTile({Key? key, required this.event}) : super(key: key);
}

class _EventTileState extends State<EventTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        if (widget.event.articleLink != 'null') {
          Utils().launchBrowser(widget.event.articleLink);
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
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: widget.event.eventYear.toString(),
                    style: TextStyle(fontSize: 12, color: theme.colorScheme.primary, fontWeight: FontWeight.w500),
                  ),
                  const TextSpan(
                    text: '   ',
                  ),
                  TextSpan(
                    text: widget.event.title == 'null' ? ' ' : widget.event.title,
                    style: TextStyle(fontSize: 12, color: theme.hintColor, fontWeight: FontWeight.w500),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
