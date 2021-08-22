import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pokeapp/modules/home/home_page.dart';
import 'package:pokeapp/styles/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poke App',
      localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
      supportedLocales: [const Locale('pt','BR')],
      debugShowCheckedModeBanner: false,
      theme: pokeTheme,
      home: HomePage(),
    );
  }
}
