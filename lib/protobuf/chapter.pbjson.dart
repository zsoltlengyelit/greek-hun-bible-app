///
//  Generated code. Do not modify.
//  source: chapter.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const Chapter$json = const {
  '1': 'Chapter',
  '2': const [
    const {'1': 'verses', '3': 1, '4': 3, '5': 11, '6': '.interlang.Chapter.Verse', '10': 'verses'},
  ],
  '3': const [Chapter_Verse$json],
};

const Chapter_Verse$json = const {
  '1': 'Verse',
  '2': const [
    const {'1': 'words', '3': 1, '4': 3, '5': 11, '6': '.interlang.Chapter.Verse.Word', '10': 'words'},
  ],
  '3': const [Chapter_Verse_Word$json],
};

const Chapter_Verse_Word$json = const {
  '1': 'Word',
  '2': const [
    const {'1': 'greek', '3': 1, '4': 2, '5': 9, '10': 'greek'},
    const {'1': 'hun', '3': 2, '4': 2, '5': 9, '10': 'hun'},
    const {'1': 'word_id', '3': 3, '4': 2, '5': 9, '10': 'wordId'},
    const {'1': 'szhuversid', '3': 4, '4': 2, '5': 9, '10': 'szhuversid'},
    const {'1': 'morph', '3': 5, '4': 2, '5': 9, '10': 'morph'},
  ],
};

const ExtendedChapter$json = const {
  '1': 'ExtendedChapter',
  '2': const [
    const {'1': 'words', '3': 1, '4': 3, '5': 11, '6': '.interlang.ExtendedChapter.WordEntry', '10': 'words'},
  ],
  '3': const [ExtendedChapter_WordEntry$json],
};

const ExtendedChapter_WordEntry$json = const {
  '1': 'WordEntry',
  '2': const [
    const {'1': 'word_id', '3': 1, '4': 2, '5': 9, '10': 'wordId'},
    const {'1': 'hun_ext', '3': 2, '4': 2, '5': 9, '10': 'hunExt'},
  ],
};

