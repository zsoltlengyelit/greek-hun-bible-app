import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'corposues.dart';
import 'selector_dialog.dart';

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
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(0),
                      content: DialogContent(args, corpuses, selectionChange),
                      titlePadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      title: Container(
                        padding: EdgeInsets.all(0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              StreamBuilder(
                                  stream: selectionChange,
                                  builder: (context, snap) {
                                    Selection data = snap.data;
                                    return data?.type == SelectionType.Corpus ||
                                            data == null
                                        ? Spacer()
                                        : FlatButton(
                                            child: Icon(Icons.arrow_back),
                                            onPressed: () {
                                              switch (data.type) {
                                                case SelectionType.Corpus:
                                                  break;
                                                case SelectionType.Book:
                                                  selectionChange
                                                      .add(Selection());
                                                  break;
                                                case SelectionType.Chapter:
                                                  selectionChange.add(
                                                      Selection.copy(
                                                          SelectionType.Book,
                                                          data.corpus,
                                                          null));
                                                  break;
                                                case SelectionType.Verse:
                                                  selectionChange.add(
                                                      Selection.copy(
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
                                      }))
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
                  });
            },
          )
        ],
      ),
      body: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: <Widget>[
          StreamBuilder(
              stream: selectionChange,
              builder: (context, snapshot) {
                Selection data = snapshot.data;
                return Text(data.toString());
              })
        ],
      ),
    );
  }

  getDialogTitle() {}

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

class DialogContent extends StatelessWidget {
  final TextPresenterPageArgs args;
  final List<Corpus> corpuses;
  final Subject<Selection> selectionChange;

  DialogContent(this.args, this.corpuses, this.selectionChange);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        padding: EdgeInsets.all(0.0),
        child: StreamBuilder(
            stream: selectionChange,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.active) {
                Selection data = snap.data;
                return buildSelector(context, data);
              }
              return Column();
            }));
  }

  buildSelector(BuildContext context, Selection selection) {
    switch (selection.type) {
      case SelectionType.Corpus:
        return CorpusSelectorGrid(corpuses, (corpus) {
          selection.type = SelectionType.Book;
          selection.corpus = corpus;
          selectionChange.add(selection);
        });
      case SelectionType.Book:
        return BookSelectorGrid(selection.corpus, (book) {
          selection.book = book;
          selection.type = SelectionType.Chapter;
          selectionChange.add(selection);
        });
      case SelectionType.Chapter:
        return ChapterSelectorGrid(selection.book, selection.corpus, (chapter) {
          selection.chapter = chapter;
          selection.type = SelectionType.Verse;
          selectionChange.add(selection);
        });
      case SelectionType.Verse:
        return VerseSelectorGrid(
            selection.chapter, selection.book, selection.corpus, (verse) {
          selection.verse = verse;
          selectionChange.add(selection);
          Navigator.pop(context);
        });
    }
  }
}
