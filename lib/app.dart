import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wikipedia_onthisdayevents/pages/home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Color bottomOverlayColor = Theme.of(context).bottomNavigationBarTheme.backgroundColor!;
    final Color topOverlayColor = Theme.of(context).bottomAppBarColor;

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor: bottomOverlayColor,
          statusBarColor: topOverlayColor,
        ),
        child: Home()
    );
  }
}
