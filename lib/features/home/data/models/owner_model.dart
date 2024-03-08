import 'dart:convert';

import 'package:flutter/widgets.dart';

class OwnerModel {
  final String id;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? picture;
  OwnerModel({
    required this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
  });

  OwnerModel copyWith({
    String? id,
    ValueGetter<String?>? title,
    ValueGetter<String?>? firstName,
    ValueGetter<String?>? lastName,
    ValueGetter<String?>? picture,
  }) {
    return OwnerModel(
      id: id ?? this.id,
      title: title != null ? title() : this.title,
      firstName: firstName != null ? firstName() : this.firstName,
      lastName: lastName != null ? lastName() : this.lastName,
      picture: picture != null ? picture() : this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'picture': picture,
    }..removeWhere((_, v) => v == null);
  }

  factory OwnerModel.fromMap(Map<String, dynamic> map) {
    return OwnerModel(
      id: map['id'] ?? '',
      title: map['title'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      picture: map['picture'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnerModel.fromJson(String source) =>
      OwnerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OwnerModel(id: $id, title: $title, firstName: $firstName, lastName: $lastName, picture: $picture)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnerModel &&
        other.id == id &&
        other.title == title &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.picture == picture;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        picture.hashCode;
  }
}
