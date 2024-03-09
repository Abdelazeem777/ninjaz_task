// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class PostRealm extends _PostRealm
    with RealmEntity, RealmObjectBase, RealmObject {
  PostRealm(
    String id,
    int likes, {
    String? image,
    String? text,
    DateTime? publishDate,
    OwnerRealm? owner,
    Iterable<String> tags = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'image', image);
    RealmObjectBase.set(this, 'likes', likes);
    RealmObjectBase.set(this, 'text', text);
    RealmObjectBase.set(this, 'publishDate', publishDate);
    RealmObjectBase.set(this, 'owner', owner);
    RealmObjectBase.set<RealmList<String>>(
        this, 'tags', RealmList<String>(tags));
  }

  PostRealm._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get image => RealmObjectBase.get<String>(this, 'image') as String?;
  @override
  set image(String? value) => RealmObjectBase.set(this, 'image', value);

  @override
  int get likes => RealmObjectBase.get<int>(this, 'likes') as int;
  @override
  set likes(int value) => RealmObjectBase.set(this, 'likes', value);

  @override
  RealmList<String> get tags =>
      RealmObjectBase.get<String>(this, 'tags') as RealmList<String>;
  @override
  set tags(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get text => RealmObjectBase.get<String>(this, 'text') as String?;
  @override
  set text(String? value) => RealmObjectBase.set(this, 'text', value);

  @override
  DateTime? get publishDate =>
      RealmObjectBase.get<DateTime>(this, 'publishDate') as DateTime?;
  @override
  set publishDate(DateTime? value) =>
      RealmObjectBase.set(this, 'publishDate', value);

  @override
  OwnerRealm? get owner =>
      RealmObjectBase.get<OwnerRealm>(this, 'owner') as OwnerRealm?;
  @override
  set owner(covariant OwnerRealm? value) =>
      RealmObjectBase.set(this, 'owner', value);

  @override
  Stream<RealmObjectChanges<PostRealm>> get changes =>
      RealmObjectBase.getChanges<PostRealm>(this);

  @override
  PostRealm freeze() => RealmObjectBase.freezeObject<PostRealm>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PostRealm._);
    return const SchemaObject(ObjectType.realmObject, PostRealm, 'PostRealm', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('image', RealmPropertyType.string, optional: true),
      SchemaProperty('likes', RealmPropertyType.int),
      SchemaProperty('tags', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('text', RealmPropertyType.string, optional: true),
      SchemaProperty('publishDate', RealmPropertyType.timestamp,
          optional: true),
      SchemaProperty('owner', RealmPropertyType.object,
          optional: true, linkTarget: 'OwnerRealm'),
    ]);
  }
}

class OwnerRealm extends _OwnerRealm
    with RealmEntity, RealmObjectBase, RealmObject {
  OwnerRealm(
    String id, {
    String? title,
    String? firstName,
    String? lastName,
    String? picture,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'firstName', firstName);
    RealmObjectBase.set(this, 'lastName', lastName);
    RealmObjectBase.set(this, 'picture', picture);
  }

  OwnerRealm._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get title => RealmObjectBase.get<String>(this, 'title') as String?;
  @override
  set title(String? value) => RealmObjectBase.set(this, 'title', value);

  @override
  String? get firstName =>
      RealmObjectBase.get<String>(this, 'firstName') as String?;
  @override
  set firstName(String? value) => RealmObjectBase.set(this, 'firstName', value);

  @override
  String? get lastName =>
      RealmObjectBase.get<String>(this, 'lastName') as String?;
  @override
  set lastName(String? value) => RealmObjectBase.set(this, 'lastName', value);

  @override
  String? get picture =>
      RealmObjectBase.get<String>(this, 'picture') as String?;
  @override
  set picture(String? value) => RealmObjectBase.set(this, 'picture', value);

  @override
  Stream<RealmObjectChanges<OwnerRealm>> get changes =>
      RealmObjectBase.getChanges<OwnerRealm>(this);

  @override
  OwnerRealm freeze() => RealmObjectBase.freezeObject<OwnerRealm>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(OwnerRealm._);
    return const SchemaObject(
        ObjectType.realmObject, OwnerRealm, 'OwnerRealm', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string, optional: true),
      SchemaProperty('firstName', RealmPropertyType.string, optional: true),
      SchemaProperty('lastName', RealmPropertyType.string, optional: true),
      SchemaProperty('picture', RealmPropertyType.string, optional: true),
    ]);
  }
}
