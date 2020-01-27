import 'package:flutter/material.dart';

import 'corposues.dart';

abstract class SelectorGrid<A> extends StatefulWidget {
  final List<A> items;
  final Function(BuildContext, A) onTap;
  final int colPerRow;

  SelectorGrid(this.items, this.onTap, [this.colPerRow = 6]);

  @override
  State<StatefulWidget> createState() {
    return _SelectorGridState(items, onTap, (item) => labelOf(item), colPerRow);
  }

  String labelOf(A item);
}

class _SelectorGridState<A> extends State<SelectorGrid<A>> {
  List<A> items;
  Function onTap;
  String Function(A item) converter;
  int colPreRow;

  _SelectorGridState(this.items, this.onTap, this.converter, this.colPreRow);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: colPreRow,
      scrollDirection: Axis.vertical,
      children: items
          .map((item) => FlatButton(
              onPressed: () {
                this.onTap(context, item);
              },
              child: Center(
                  child: Text(
                converter(item),
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
              ))))
          .toList(),
    ));
  }
}

class CorpusSelectorGrid extends SelectorGrid<Corpus> {
  CorpusSelectorGrid(List<Corpus> corpuses, void Function(Corpus) action)
      : super(corpuses, (context, corpus) {
          action(corpus);
        }, 2);

  @override
  String labelOf(Corpus item) {
    return item.nev;
  }
}
// ---------------------

class BookSelectorGrid extends SelectorGrid<Book> {
  BookSelectorGrid(Corpus corpus, void Function(Book) action)
      : super(corpus.books, (context, item) {
          action(item);
        }, 4);

  @override
  String labelOf(Book item) {
    return item.nev;
  }
}

// ---------------------
class ChapterlectorPageArgs {
  Book book;
  Corpus corpus;

  ChapterlectorPageArgs(this.book, this.corpus);
}

class ChapterSelectorGrid extends SelectorGrid<Chapter> {
  ChapterSelectorGrid(Book book, Corpus corpus, void Function(Chapter) action)
      : super(book.chapters, (context, item) {
          action(item);
        }, 4);

  @override
  String labelOf(Chapter item) {
    return item.index.toString();
  }
}

class VerseSelectorGrid extends SelectorGrid<Verse> {
  VerseSelectorGrid(
      Chapter chapter, Book book, Corpus corpus, void Function(Verse) action)
      : super(List.generate(chapter.length, (i) => Verse(i + 1)),
            (context, item) {
          action(item);
        }, 5);

  @override
  String labelOf(Verse item) {
    return item.index.toString();
  }
}

class VerseSelectorPageArgs {
  final Book book;
  final Chapter chapter;

  Corpus corpus;

  VerseSelectorPageArgs(this.book, this.chapter, this.corpus);
}
