import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'chapter_presenter.dart';
import 'corposues.dart';
import 'dialog_content.dart';

class TextPresenterPageArgs {
  Verse verse;
  Chapter chapter;
  Book book;
  Corpus corpus;

  TextPresenterPageArgs(this.verse, this.chapter, this.book, this.corpus);
}

enum SelectionType { Corpus, Book, Chapter, Verse }

class Selection {
  SelectionType type = SelectionType.Corpus;
  Corpus corpus;
  Book book;
  Chapter chapter;
  Verse verse;

  factory Selection.copy(SelectionType type, Corpus corpus, Book book) {
    var selection = Selection();
    selection.type = type;
    selection.corpus = corpus;
    selection.book = book;
    return selection;
  }

  Selection();

  @override
  String toString() {
    return "${corpus?.nev} ${book?.nev} ${chapter?.index} ${verse?.index}";
  }
}

class TextPresenterPage extends StatelessWidget {
  final TextPresenterPageArgs args;
  final List<Corpus> corpuses;
  final selectionChange = BehaviorSubject<Selection>.seeded(
      Selection()..type = SelectionType.Corpus);

  TextPresenterPage(this.args, this.corpuses);

  void dispose() {
    selectionChange.close();
  }

  String title() =>
      "${args.corpus.nev} ${args.book.nev} ${args.chapter.index},${args.verse.index}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title()),
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(context: context, builder: this.buildDialog);
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: StreamBuilder(
              stream: selectionChange,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  Selection data = snapshot.data;
                  return ChapterPresenter(data);
                }
                return Text('Nincs kivalasztva');
              })),
    );
  }

  getDialogTitle() {}

  Widget buildDialog(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: DialogContent(args, corpuses, selectionChange),
      titlePadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      title: Container(
        padding: EdgeInsets.all(0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StreamBuilder(
                  stream: selectionChange,
                  builder: (context, snap) {
                    Selection data = snap.data;
                    return data?.type == SelectionType.Corpus || data == null
                        ? Spacer()
                        : FlatButton(
                            child: Icon(Icons.arrow_back),
                            onPressed: () {
                              switch (data.type) {
                                case SelectionType.Corpus:
                                  break;
                                case SelectionType.Book:
                                  selectionChange.add(Selection());
                                  break;
                                case SelectionType.Chapter:
                                  selectionChange.add(Selection.copy(
                                      SelectionType.Book, data.corpus, null));
                                  break;
                                case SelectionType.Verse:
                                  selectionChange.add(Selection.copy(
                                      SelectionType.Chapter,
                                      data.corpus,
                                      data.book));
                                  break;
                              }
                            },
                          );
                  }),
              Expanded(
                  child: StreamBuilder(
                      stream: selectionChange,
                      builder: (context, snapshot) {
                        Selection data = snapshot.data;
                        String title = dialogTitle(data);

                        return Text(title);
                      })),
              Align()
            ]),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        )
      ],
    );
  }

  String dialogTitle(Selection data) {
    switch (data?.type) {
      case SelectionType.Corpus:
        return ('');
      case SelectionType.Book:
        return ('Könyv');
      case SelectionType.Chapter:
        return ('Fejezet');
      case SelectionType.Verse:
        return 'Vers';
    }
    return "";
  }
}
