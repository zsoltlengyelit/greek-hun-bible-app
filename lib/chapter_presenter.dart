import 'dart:async';

import 'package:UjSzov/protobuf/chapter.pb.dart';
import 'package:UjSzov/text_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ChapterPresenter extends StatelessWidget {
  Selection selection;
  Function(BuildContext c) searchOpener;

  ChapterPresenter(this.selection, this.searchOpener);

  Future<Chapter> loadChapter() async {
    var protoFileData = await rootBundle.load(
        'assets/protobuf_data/${selection.corpus.id}_${selection.book.konyv_id}_${selection.chapter.index}.bin');
    dynamic data = Chapter.fromBuffer(protoFileData.buffer.asUint8List());
    return data;
  }

  Future<ExtendedChapter> loadExtendedChapter() async {
    var protoFileData = await rootBundle.load(
        'assets/protobuf_data/${selection.corpus.id}_${selection.book.konyv_id}_${selection.chapter.index}.ext.bin');
    dynamic data =
        ExtendedChapter.fromBuffer(protoFileData.buffer.asUint8List());
    return data;
  }

  @override
  Widget build(BuildContext context) {
    if (selection.corpus == null ||
        selection.book == null ||
        selection.chapter == null) {
      return Center(
          child: GestureDetector(
              child: Icon(
                Icons.book,
                size: 200,
                color: Colors.lightGreen,
              ),
              onTap: () {
                this.searchOpener(context);
              }));
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
                Chapter chapter = snap.data;

                return buildSentences(chapter);
              } else {
                return Container(
                    child: Center(child: Icon(Icons.swap_vertical_circle)));
              }
            }));
  }

  Wrap buildSentences(Chapter chapter) {
    var list = chapter.verses
        .asMap()
        .map((index, verse) {
          var words =
              verse.words.skip(1).map(mapWordBlock).toList(growable: true);

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
  }

  Widget mapWordBlock(word) =>
      WordBlock(word, () => this.loadExtendedChapter());

  Stream<Chapter> loadVerses() {
    return Stream.fromFuture(loadChapter());
  }
}

class WordBlock extends StatelessWidget {
  Chapter_Verse_Word word;
  Future<ExtendedChapter> Function() extensionLoader;

  WordBlock(this.word, this.extensionLoader);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
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
            )),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    content: StreamBuilder(
                        stream: Stream.fromFuture(this.extensionLoader()),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Icon(Icons.swap_vertical_circle);
                          }
                          if (snap.connectionState == ConnectionState.done) {
                            ExtendedChapter ch = snap.data;
                            var wordExt = ch.words.firstWhere((entry) {
                              return entry.wordId == this.word.wordId;
                            });
                            return Text(wordExt.hunExt);
                          }
                          return Text("Error");
                        }));
              });
        });
  }
}
