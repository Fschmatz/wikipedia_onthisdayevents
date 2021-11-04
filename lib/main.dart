import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wikipedia_onthisdayevents/app.dart';
import 'package:wikipedia_onthisdayevents/util/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),

    child: Consumer<ThemeNotifier>(
      builder:(context, ThemeNotifier notifier, child){
        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          home: const App(),
        );
      },
    ),
  )
  );
}


