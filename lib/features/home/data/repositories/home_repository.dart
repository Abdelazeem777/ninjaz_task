import '../datasources/home_local_data_source.dart';
import '../datasources/home_remote_data_source.dart';
import '../models/post_model.dart';

abstract class HomeRepository {
  Future<List<PostModel>> getPosts({int page = 0, int limit = 10});
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;

  HomeRepositoryImpl({
    required HomeRemoteDataSource homeRemoteDataSource,
    required HomeLocalDataSource homeLocalDataSource,
  })  : _remoteDataSource = homeRemoteDataSource,
        _localDataSource = homeLocalDataSource;

  @override
  Future<List<PostModel>> getPosts({int page = 0, int limit = 10}) {
    return _remoteDataSource.getPosts(page: page, limit: limit);
  }
}
