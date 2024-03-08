import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ninjaz_task/features/home/data/models/owner_model.dart';

class PostModel {
  final String id;
  final String? image;
  final int likes;
  final List<String>? tags;
  final String? text;
  final String? publishDate;
  final OwnerModel? owner;
  PostModel({
    required this.id,
    this.image,
    required this.likes,
    this.tags,
    this.text,
    this.publishDate,
    this.owner,
  });

  PostModel copyWith({
    String? id,
    ValueGetter<String?>? image,
    int? likes,
    ValueGetter<List<String>?>? tags,
    ValueGetter<String?>? text,
    ValueGetter<String?>? publishDate,
    ValueGetter<OwnerModel?>? owner,
  }) {
    return PostModel(
      id: id ?? this.id,
      image: image != null ? image() : this.image,
      likes: likes ?? this.likes,
      tags: tags != null ? tags() : this.tags,
      text: text != null ? text() : this.text,
      publishDate: publishDate != null ? publishDate() : this.publishDate,
      owner: owner != null ? owner() : this.owner,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'likes': likes,
      'tags': tags,
      'text': text,
      'publishDate': publishDate,
      'owner': owner?.toMap(),
    }..removeWhere((_, v) => v == null);
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? '',
      image: map['image'],
      likes: map['likes']?.toInt() ?? 0,
      tags: List<String>.from(map['tags']),
      text: map['text'],
      publishDate: map['publishDate'],
      owner: map['owner'] != null ? OwnerModel.fromMap(map['owner']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(id: $id, image: $image, likes: $likes, tags: $tags, text: $text, publishDate: $publishDate, owner: $owner)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.id == id &&
        other.image == image &&
        other.likes == likes &&
        listEquals(other.tags, tags) &&
        other.text == text &&
        other.publishDate == publishDate &&
        other.owner == owner;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        likes.hashCode ^
        tags.hashCode ^
        text.hashCode ^
        publishDate.hashCode ^
        owner.hashCode;
  }
}
