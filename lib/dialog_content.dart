import 'package:UjSzov/selector_dialog.dart';
import 'package:UjSzov/text_presenter.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'corposues.dart';

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
