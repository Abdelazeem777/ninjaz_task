import '../../../../core/service/network_service.dart';

abstract class SplashRemoteDataSource {
 
}

class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final NetworkService _networkService;
  SplashRemoteDataSourceImpl(this._networkService);
 
}
