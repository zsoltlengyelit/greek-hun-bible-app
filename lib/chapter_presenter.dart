import 'dart:async';
import 'dart:convert';

import 'package:UjSzov/text_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ChapterPresenter extends StatelessWidget {
  Selection selection;

  ChapterPresenter(this.selection);

  Future<dynamic> loadAsset() async {
    var jsonString = await rootBundle.loadString(
        'assets/chapters/${selection.corpus.id}_${selection.book.konyv_id}_${selection.chapter.index}.json');
    dynamic data = jsonDecode(jsonString);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    if (selection.corpus == null ||
        selection.book == null ||
        selection.chapter == null) {
      return Text("Select");
    }
    return SingleChildScrollView(
        padding: EdgeInsets.all(0),
        child: StreamBuilder(
            stream: this.loadVerses(),
            builder: (context, snap) {
              if (snap.error != null) {
                return Text(
                  snap.error.toString(),
                  style: TextStyle(color: Colors.red),
                );
              }
              if (snap.connectionState == ConnectionState.done) {
                TextChapter chapter = snap.data;

                var list = chapter.verses
                    .asMap()
                    .map((index, verse) {
                      var words = verse.words
                          .skip(1)
                          .map((word) => (WordBlock(word) as Widget))
                          .toList(growable: true);

                      words.insert(
                          0,
                          Text(
                            (index + 1).toString(),
                            style: TextStyle(color: Colors.lightBlue),
                          ));
                      return MapEntry(index, words);
                    })
                    .values
                    .toList()
                    .expand((i) => i)
                    .toList();
                return Wrap(spacing: 10, runSpacing: 10, children: list);
              } else {
                return Text("Loading...");
              }
            }));
  }

  Stream<TextChapter> loadVerses() {
    return Stream.fromFuture(loadAsset())
        .map((data) => convertTextChapter(data));
  }
}

class WordBlock extends StatelessWidget {
  TextWord word;
  WordBlock(this.word);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Text(
              word.hun,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(word.greek, style: TextStyle(fontSize: 16))
          ],
        ));
  }
}

TextChapter convertTextChapter(dynamic data) =>
    TextChapter(convertVerses(data["verses"]));

List<TextVerse> convertVerses(List<dynamic> verses) =>
    verses.map((vers) => TextVerse(convertWords(vers["words"]))).toList();

List<TextWord> convertWords(List<dynamic> words) {
  return words.map((word) {
    return TextWord(word["greek"], word["hun"], word["hunExt"], word["wordId"],
        word["szhuVersId"], word["morph"]);
  }).toList();
}

class TextChapter {
  List<TextVerse> verses;

  TextChapter(this.verses);
}

class TextVerse {
  List<TextWord> words;
  TextVerse(this.words);
}

class TextWord {
  String greek;
  String hun;
  String hunExt;
  String wordId;
  String szhuVersId;
  String morph;

  TextWord(this.greek, this.hun, this.hunExt, this.wordId, this.szhuVersId,
      this.morph);
}
