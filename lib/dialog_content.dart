import 'package:UjSzov/selector_dialog.dart';
import 'package:UjSzov/text_presenter.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'corposues.dart';
import 'dialog_page_controller.dart';

class DialogContent extends StatelessWidget {
  final TextPresenterPageArgs args;
  final List<Corpus> corpuses;
  final Subject<Selection> selectionChange;
  final DialogPageController pageController;

  DialogContent(
      this.args, this.corpuses, this.selectionChange, this.pageController);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        padding: EdgeInsets.all(0.0),
        child: StreamBuilder(
            stream: selectionChange,
            builder: (ctx, snap) {
              if (snap.connectionState == ConnectionState.active) {
                Selection selection = snap.data;

                var children = <Widget>[
                  buildSelector(ctx, selection, SelectionType.Corpus),
                ];

                if (selection.corpus != null) {
                  children
                      .add(buildSelector(ctx, selection, SelectionType.Book));
                }

                if (selection.book != null) {
                  children.add(
                      buildSelector(ctx, selection, SelectionType.Chapter));
                }

                return PageView(
                  scrollDirection: Axis.horizontal,
                  children: children,
                  pageSnapping: true,
                  controller: pageController,
                );
              }
              return Text('Nope');
            }));
  }

  buildSelector(BuildContext context, Selection selection, SelectionType type) {
    switch (type) {
      case SelectionType.Corpus:
        return CorpusSelectorGrid(corpuses, (corpus) {
          selection.type = SelectionType.Book;
          selection.corpus = corpus;
          selection.book = null;
          selection.chapter = null;
          selectionChange.add(selection);
          pageController.goTo(1);
        });
      case SelectionType.Book:
        return selection.corpus != null
            ? BookSelectorGrid(selection.corpus, (book) {
                selection.book = book;
                selection.chapter = null;
                selection.type = SelectionType.Chapter;
                selectionChange.add(selection);
                pageController.goTo(2);
              })
            : Text('nope book');
      case SelectionType.Chapter:
        return selection.book != null
            ? ChapterSelectorGrid(selection.book, selection.corpus, (chapter) {
                selection.chapter = chapter;
                selectionChange.add(selection);
                Navigator.pop(context);
              })
            : Text('nope chapter');
    }
  }
}
