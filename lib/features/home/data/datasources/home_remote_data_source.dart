import '../../../../core/service/network_service.dart';

abstract class HomeRemoteDataSource {
 
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final NetworkService _networkService;
  HomeRemoteDataSourceImpl(this._networkService);
 
}
