List<Corpus> convertCorpuses(List<dynamic> data) => data
    .map((corpusObj) => Corpus(
        convertBooks(corpusObj["books"]), corpusObj["id"], corpusObj["nev"]))
    .toList();

List<Book> convertBooks(List<dynamic> booksObjs) => booksObjs
    .map((bookObj) => Book(
        convertChapters(bookObj["chapters"]),
        bookObj["hossz"],
        bookObj["konyv_id"],
        bookObj["nev"],
        bookObj["tipus"]))
    .toList();

List<Chapter> convertChapters(List<dynamic> chapters) => chapters
    .where((ch) => ch != null)
    .map((chapter) => Chapter(chapter["index"], chapter["length"]))
    .toList();

class Corpus {
  List<Book> books;
  int id;
  String nev;

  Corpus(this.books, this.id, this.nev);
}

class Book {
  List<Chapter> chapters;
  int hossz;
  int konyv_id;
  String nev;
  String tipus;

  Book(this.chapters, this.hossz, this.konyv_id, this.nev, this.tipus);
}

class Chapter {
  int index;
  int length;

  Chapter(this.index, this.length);
}

class Verse {
  int index;

  Verse(this.index);
}
