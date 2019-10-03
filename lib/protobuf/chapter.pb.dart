///
//  Generated code. Do not modify.
//  source: chapter.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Chapter_Verse_Word extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Chapter.Verse.Word', package: const $pb.PackageName('interlang'), createEmptyInstance: create)
    ..aQS(1, 'greek')
    ..aQS(2, 'hun')
    ..aQS(3, 'wordId')
    ..aQS(4, 'szhuversid')
    ..aQS(5, 'morph')
  ;

  Chapter_Verse_Word._() : super();
  factory Chapter_Verse_Word() => create();
  factory Chapter_Verse_Word.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Chapter_Verse_Word.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Chapter_Verse_Word clone() => Chapter_Verse_Word()..mergeFromMessage(this);
  Chapter_Verse_Word copyWith(void Function(Chapter_Verse_Word) updates) => super.copyWith((message) => updates(message as Chapter_Verse_Word));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Chapter_Verse_Word create() => Chapter_Verse_Word._();
  Chapter_Verse_Word createEmptyInstance() => create();
  static $pb.PbList<Chapter_Verse_Word> createRepeated() => $pb.PbList<Chapter_Verse_Word>();
  @$core.pragma('dart2js:noInline')
  static Chapter_Verse_Word getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Chapter_Verse_Word>(create);
  static Chapter_Verse_Word _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get greek => $_getSZ(0);
  @$pb.TagNumber(1)
  set greek($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGreek() => $_has(0);
  @$pb.TagNumber(1)
  void clearGreek() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get hun => $_getSZ(1);
  @$pb.TagNumber(2)
  set hun($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHun() => $_has(1);
  @$pb.TagNumber(2)
  void clearHun() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get wordId => $_getSZ(2);
  @$pb.TagNumber(3)
  set wordId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWordId() => $_has(2);
  @$pb.TagNumber(3)
  void clearWordId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get szhuversid => $_getSZ(3);
  @$pb.TagNumber(4)
  set szhuversid($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSzhuversid() => $_has(3);
  @$pb.TagNumber(4)
  void clearSzhuversid() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get morph => $_getSZ(4);
  @$pb.TagNumber(5)
  set morph($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMorph() => $_has(4);
  @$pb.TagNumber(5)
  void clearMorph() => clearField(5);
}

class Chapter_Verse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Chapter.Verse', package: const $pb.PackageName('interlang'), createEmptyInstance: create)
    ..pc<Chapter_Verse_Word>(1, 'words', $pb.PbFieldType.PM, subBuilder: Chapter_Verse_Word.create)
  ;

  Chapter_Verse._() : super();
  factory Chapter_Verse() => create();
  factory Chapter_Verse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Chapter_Verse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Chapter_Verse clone() => Chapter_Verse()..mergeFromMessage(this);
  Chapter_Verse copyWith(void Function(Chapter_Verse) updates) => super.copyWith((message) => updates(message as Chapter_Verse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Chapter_Verse create() => Chapter_Verse._();
  Chapter_Verse createEmptyInstance() => create();
  static $pb.PbList<Chapter_Verse> createRepeated() => $pb.PbList<Chapter_Verse>();
  @$core.pragma('dart2js:noInline')
  static Chapter_Verse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Chapter_Verse>(create);
  static Chapter_Verse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Chapter_Verse_Word> get words => $_getList(0);
}

class Chapter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Chapter', package: const $pb.PackageName('interlang'), createEmptyInstance: create)
    ..pc<Chapter_Verse>(1, 'verses', $pb.PbFieldType.PM, subBuilder: Chapter_Verse.create)
  ;

  Chapter._() : super();
  factory Chapter() => create();
  factory Chapter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Chapter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Chapter clone() => Chapter()..mergeFromMessage(this);
  Chapter copyWith(void Function(Chapter) updates) => super.copyWith((message) => updates(message as Chapter));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Chapter create() => Chapter._();
  Chapter createEmptyInstance() => create();
  static $pb.PbList<Chapter> createRepeated() => $pb.PbList<Chapter>();
  @$core.pragma('dart2js:noInline')
  static Chapter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Chapter>(create);
  static Chapter _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Chapter_Verse> get verses => $_getList(0);
}

class ExtendedChapter_WordEntry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ExtendedChapter.WordEntry', package: const $pb.PackageName('interlang'), createEmptyInstance: create)
    ..aQS(1, 'wordId')
    ..aQS(2, 'hunExt')
  ;

  ExtendedChapter_WordEntry._() : super();
  factory ExtendedChapter_WordEntry() => create();
  factory ExtendedChapter_WordEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExtendedChapter_WordEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ExtendedChapter_WordEntry clone() => ExtendedChapter_WordEntry()..mergeFromMessage(this);
  ExtendedChapter_WordEntry copyWith(void Function(ExtendedChapter_WordEntry) updates) => super.copyWith((message) => updates(message as ExtendedChapter_WordEntry));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExtendedChapter_WordEntry create() => ExtendedChapter_WordEntry._();
  ExtendedChapter_WordEntry createEmptyInstance() => create();
  static $pb.PbList<ExtendedChapter_WordEntry> createRepeated() => $pb.PbList<ExtendedChapter_WordEntry>();
  @$core.pragma('dart2js:noInline')
  static ExtendedChapter_WordEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExtendedChapter_WordEntry>(create);
  static ExtendedChapter_WordEntry _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get wordId => $_getSZ(0);
  @$pb.TagNumber(1)
  set wordId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWordId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWordId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get hunExt => $_getSZ(1);
  @$pb.TagNumber(2)
  set hunExt($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHunExt() => $_has(1);
  @$pb.TagNumber(2)
  void clearHunExt() => clearField(2);
}

class ExtendedChapter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ExtendedChapter', package: const $pb.PackageName('interlang'), createEmptyInstance: create)
    ..pc<ExtendedChapter_WordEntry>(1, 'words', $pb.PbFieldType.PM, subBuilder: ExtendedChapter_WordEntry.create)
  ;

  ExtendedChapter._() : super();
  factory ExtendedChapter() => create();
  factory ExtendedChapter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExtendedChapter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ExtendedChapter clone() => ExtendedChapter()..mergeFromMessage(this);
  ExtendedChapter copyWith(void Function(ExtendedChapter) updates) => super.copyWith((message) => updates(message as ExtendedChapter));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExtendedChapter create() => ExtendedChapter._();
  ExtendedChapter createEmptyInstance() => create();
  static $pb.PbList<ExtendedChapter> createRepeated() => $pb.PbList<ExtendedChapter>();
  @$core.pragma('dart2js:noInline')
  static ExtendedChapter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExtendedChapter>(create);
  static ExtendedChapter _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ExtendedChapter_WordEntry> get words => $_getList(0);
}

