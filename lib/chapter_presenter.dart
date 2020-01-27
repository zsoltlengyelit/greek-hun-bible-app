import 'dart:async';
import 'dart:math';

import 'package:UjSzov/protobuf/chapter.pb.dart';
import 'package:UjSzov/text_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:html/parser.dart';
import 'package:rxdart/rxdart.dart';

class ChapterPresenter extends StatelessWidget {
  final Selection selection;
  final Function(BuildContext c) searchOpener;

  Future<Chapter> chapterData;
  Future<ExtendedChapter> extChapterData;

  ChapterPresenter(this.selection, this.searchOpener);

  Future<Chapter> loadChapter() async {
    if (chapterData == null) {
      chapterData = _loadChapter();
    }
    return chapterData;
  }

  Future<Chapter> _loadChapter() async {
    var protoFileData = await rootBundle.load(
        'assets/protobuf_data/${selection.corpus.id}_${selection.book.konyv_id}_${selection.chapter.index}.bin');
    Chapter data = Chapter.fromBuffer(protoFileData.buffer.asUint8List());
    return data;
  }

  Future<ExtendedChapter> loadExtendedChapter() async {
    if (extChapterData == null) {
      extChapterData = _loadExtendedChapter();
    }
    return extChapterData;
  }

  Future<ExtendedChapter> _loadExtendedChapter() async {
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

    var scaleS = BehaviorSubject<double>.seeded(1.0);

    return GestureDetector(
        onScaleUpdate: (details) {
          var scale = details.scale;
          scaleS.add(scale);
        },
        child: SingleChildScrollView(
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
                    return StreamBuilder(
                      builder: (c, s) {
                        if (s.connectionState == ConnectionState.active) {
                          return buildSentences(chapter, s.data);
                        }
                        return Text('');
                      },
                      stream: scaleS,
                    );
                  } else {
                    return Container(
                        alignment: Alignment.center,
                        child: Center(child: Icon(Icons.swap_vertical_circle)));
                  }
                })));
  }

  Widget buildSentences(Chapter chapter, double scale) {
    var verses = chapter.verses
        .asMap()
        .map((index, verse) {
          var words = verse.words
              .skip(1)
              .map(mapWordBlock(scale))
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
        .map((verses) {
          return Wrap(children: verses, runSpacing: 5, spacing: 5);
        })
        .toList();

    return Column(children: verses);
  }

  Widget Function(Chapter_Verse_Word) mapWordBlock(double scale) {
    scale = min(max(.5, scale), 3);
    return (Chapter_Verse_Word word) {
      return WordBlock(word, scale, () => this.loadExtendedChapter());
    };
  }

  Stream<Chapter> loadVerses() {
    return Stream.fromFuture(loadChapter());
  }
}

class WordBlock extends StatelessWidget {
  Chapter_Verse_Word word;
  Future<ExtendedChapter> Function() extensionLoader;
  double scale;

  WordBlock(this.word, this.scale, this.extensionLoader);

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
                  style: TextStyle(color: Colors.grey, fontSize: 12 * scale),
                ),
                Text(word.greek, style: TextStyle(fontSize: 16 * scale))
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

                            var text2 = parse(wordExt.szf).text;

                            return SingleChildScrollView(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                  makeBold("HunExt"),
                                  Text(wordExt.hunExt),
                                  makeBold("Morph"),
                                  Text(wordExt.morph),
                                  makeBold("Dictmj"),
                                  Text(wordExt.dictmj),
                                  makeBold("Valt"),
                                  Text(wordExt.dictvalt),
                                  makeBold("Szal"),
                                  Text(wordExt.szal),
                                  makeBold("Szhu"),
                                  Text(wordExt.szhuversid),
                                  makeBold("Szf"),
                                  Text(text2 ?? ''),
                                ]));
                          }
                          return Text("Error");
                        }));
              });
        });
  }

  makeBold(String text) {
    return Text(text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }
}
