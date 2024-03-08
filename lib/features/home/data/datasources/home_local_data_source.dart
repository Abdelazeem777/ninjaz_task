import 'package:ninjaz_task/features/home/data/models/post_model.dart';

import '../../../../core/service/cache_service.dart';

abstract class HomeLocalDataSource {
  Future<List<PostModel>> getPosts([int page = 0, int limit = 10]);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final CacheService _cacheService;
  HomeLocalDataSourceImpl(this._cacheService);

  @override
  Future<List<PostModel>> getPosts([int page = 0, int limit = 10]) async {
    //TODO: implement getPosts!
    return [];
  }
}
