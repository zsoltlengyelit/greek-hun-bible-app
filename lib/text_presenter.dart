import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'chapter_presenter.dart';
import 'corposues.dart';
import 'dialog_content.dart';
import 'dialog_page_controller.dart';

class TextPresenterPageArgs {
  Verse verse;
  Chapter chapter;
  Book book;
  Corpus corpus;

  TextPresenterPageArgs(this.verse, this.chapter, this.book, this.corpus);
}

enum SelectionType { Corpus, Book, Chapter }

class Selection {
  SelectionType type = SelectionType.Corpus;
  Corpus corpus;
  Book book;
  Chapter chapter;

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
    return "${corpus?.nev ?? ''} ${book?.nev ?? ''} ${chapter?.index ?? ''}"
        .trim();
  }
}

var defultTitle = "Görög - magyar Biblia";

class TextPresenterPage extends StatelessWidget {
  final TextPresenterPageArgs args;
  final List<Corpus> corpuses;
  final selectionChange = BehaviorSubject<Selection>.seeded(
      Selection()..type = SelectionType.Corpus);

  TextPresenterPage(this.args, this.corpuses);

  void dispose() {
    selectionChange.close();
  }

  String title(Selection sel) {
    var t =
        "${sel.corpus?.nev ?? ""} ${sel.book?.nev ?? ""} ${sel.chapter?.index ?? ""}"
            .trim();
    return t.isEmpty ? defultTitle : t;
  }

  @override
  Widget build(BuildContext context) {
    var textPageController = PageController();

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
            stream: selectionChange,
            builder: (c, snap) {
              return Text(snap.connectionState == ConnectionState.active &&
                      snap.data != null
                  ? title(snap.data)
                  : defultTitle);
            }),
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              this.openSearch(context);
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: PageView.builder(controller: textPageController ,itemBuilder: (ctx, page) {
            developer.log('page' + page.toString());
            return buildChapterPresenter();
          })),
    );
  }

  StreamBuilder<Selection> buildChapterPresenter() {
    return StreamBuilder(
        stream: selectionChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            Selection data = snapshot.data;
            return ChapterPresenter(
                data, (context) => this.openSearch(context));
          }
          return Text('Nincs kivalasztva');
        });
  }

  getDialogTitle() {}

  Widget buildDialog(BuildContext context) {
    var pageController = DialogPageController();

//    pageController.addListener(() {
//      switch (pageController.page.toInt()) {
//        case 0:
//          selectionChange.add(Selection());
//          break;
//        case 1:
//          selectionChange.add(Selection());
//          break;
//        case 2:
//          break;
//      }
//    });

    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: DialogContent(args, corpuses, selectionChange, pageController),
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
                                  // cannot happen
                                  break;
                                case SelectionType.Book:
                                  selectionChange.add(Selection());
                                  pageController.goTo(0);
                                  break;
                                case SelectionType.Chapter:
                                  selectionChange.add(Selection.copy(
                                      SelectionType.Book, data.corpus, null));
                                  pageController.goTo(1);
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

  openSearch(context) {
    showDialog(
        context: context, barrierDismissible: false, builder: this.buildDialog);
  }

  String dialogTitle(Selection data) {
    return data.toString();
  }
}
