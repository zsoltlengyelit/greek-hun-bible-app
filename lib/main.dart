import 'dart:async' show Future;
import 'dart:convert';

import 'package:UjSzov/text_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'corposues.dart';

void main() async {
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/corpuses.json');
  }

  var jsonString = await loadAsset();
  List<dynamic> data = jsonDecode(jsonString);

  List<Corpus> corpuses = convertCorpuses(data);

  return runApp(MyApp(corpuses));
}

class MyApp extends StatelessWidget {
  final List<Corpus> corpuses;

  MyApp(this.corpuses);

  @override
  Widget build(BuildContext context) {
    var ujszov = corpuses.where((c) => c.id == 2).first;
    var mate = ujszov.books.first;
    var chapter1 = mate.chapters.first;
    var initVerse = TextPresenterPageArgs(Verse(1), chapter1, mate, ujszov);

    return MaterialApp(
      initialRoute: '/',
      color: Colors.deepPurple,
      themeMode: ThemeMode.light,
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple, backgroundColor: Colors.white)),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => TextPresenterPage(initVerse, this.corpuses),
      },
    );
  }
}
