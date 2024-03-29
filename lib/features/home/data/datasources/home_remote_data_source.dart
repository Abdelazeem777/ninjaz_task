import 'package:ninjaz_task/features/home/data/models/post_model.dart';

import '../../../../api_end_point.dart';
import '../../../../core/exceptions/request_exception.dart';
import '../../../../core/service/network_service.dart';

abstract class HomeRemoteDataSource {
  Future<List<PostModel>> getPosts({int page = 0, int limit = 10});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final NetworkService _networkService;
  HomeRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<PostModel>> getPosts({int page = 0, int limit = 10}) async {
    const url = ApiEndPoint.GET_POSTS;

    return _networkService.get(
      url,
      queryParameters: {'page': page, 'limit': limit},
    ).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final data = result['data'] as List;
      return data.map((e) => PostModel.fromMap(e)).toList();
    });
  }
}
