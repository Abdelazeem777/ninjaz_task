import 'package:ninjaz_task/core/utils/connection_checker.dart';

import '../datasources/home_local_data_source.dart';
import '../datasources/home_remote_data_source.dart';
import '../models/post_model.dart';

abstract class HomeRepository {
  Future<List<PostModel>> getPosts({int page = 0, int limit = 10});
}

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required HomeRemoteDataSource homeRemoteDataSource,
    required HomeLocalDataSource homeLocalDataSource,
    required ConnectionChecker connectionChecker,
  })  : _remoteDataSource = homeRemoteDataSource,
        _localDataSource = homeLocalDataSource,
        _connectionChecker = connectionChecker;

  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;
  final ConnectionChecker _connectionChecker;

  @override
  Future<List<PostModel>> getPosts({int page = 0, int limit = 10}) async {
    if (!await _connectionChecker.hasConnection())
      return _localDataSource.getPosts(page, limit);

    final posts = await _remoteDataSource.getPosts(page: page, limit: limit);
    await _localDataSource.cachePosts(posts);
    return posts;
  }
}
