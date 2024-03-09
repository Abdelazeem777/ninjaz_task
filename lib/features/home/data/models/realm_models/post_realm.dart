import 'package:realm/realm.dart';

part 'post_realm.g.dart';

@RealmModel()
class _PostRealm {
  @PrimaryKey()
  late String id;
  String? image;
  late int likes;
  late List<String> tags;
  String? text;
  DateTime? publishDate;
  _OwnerRealm? owner;
}

@RealmModel()
class _OwnerRealm {
  @PrimaryKey()
  late String id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;
}
