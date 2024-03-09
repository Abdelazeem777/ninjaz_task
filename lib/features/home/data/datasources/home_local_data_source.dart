import 'package:ninjaz_task/features/home/data/models/owner_model.dart';
import 'package:ninjaz_task/features/home/data/models/post_model.dart';
import 'package:ninjaz_task/features/home/data/models/realm_models/post_realm.dart';
import 'package:realm/realm.dart';

import '../../../../core/service/cache_service.dart';

abstract class HomeLocalDataSource {
  Future<List<PostModel>> getPosts([int page = 0, int limit = 10]);
  Future<void> cachePosts(List<PostModel> posts);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final CacheService _cacheService;
  HomeLocalDataSourceImpl(this._cacheService);

  @override
  Future<List<PostModel>> getPosts([int page = 0, int limit = 10]) async {
    final postsRealm = await _cacheService.getAll<PostRealm>();

    final posts = postsRealm.map(_mapPostRealmToPostModel).toList();

    return posts;
  }

  PostModel _mapPostRealmToPostModel(PostRealm e) => PostModel(
      id: e.id,
      image: e.image,
      likes: e.likes,
      tags: e.tags,
      text: e.text,
      publishDate: e.publishDate,
      owner: OwnerModel(
        id: e.owner?.id ?? '',
        title: e.owner?.title,
        firstName: e.owner?.firstName,
        lastName: e.owner?.lastName,
        picture: e.owner?.picture,
      ));

  @override
  Future<void> cachePosts(List<PostModel> posts) async {
    final postsRealm = posts.map(_mapPostModelToPostRealm).toList();

    await _cacheService.addAll<PostRealm>(postsRealm);
  }

  PostRealm _mapPostModelToPostRealm(PostModel e) => PostRealm(
        e.id,
        e.likes,
        tags: RealmList(e.tags ?? []),
      )
        ..image = e.image
        ..text = e.text
        ..publishDate = e.publishDate
        ..owner = e.owner == null
            ? null
            : (OwnerRealm(e.owner!.id)
              ..title = e.owner?.title
              ..firstName = e.owner?.firstName
              ..lastName = e.owner?.lastName
              ..picture = e.owner?.picture);
}
