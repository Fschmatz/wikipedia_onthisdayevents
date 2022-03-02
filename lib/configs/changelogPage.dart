import 'package:flutter/material.dart';
import 'package:wikipedia_onthisdayevents/util/changelog.dart';

class ChangelogPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Color? accentText = Theme.of(context).colorScheme.onSecondary;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Changelog"),
        ),
        body: ListView(children: <Widget>[
          ListTile(
              leading: const SizedBox(
                height: 0.1,
              ),
              title: Text("Current Version".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: accentText))),
          ListTile(
            leading: const Icon(
              Icons.article_outlined,
            ),
            title: Text(
              Changelog.changelogCurrent,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const SizedBox(
              height: 0.1,
            ),
            title: Text("Previous Versions".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: accentText)),
          ),
          ListTile(
            leading: const Icon(
              Icons.article_outlined,
            ),
            title: Text(
              Changelog.changelogsOld,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ]));
  }
}
