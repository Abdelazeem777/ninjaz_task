import '../datasources/splash_remote_data_source.dart';

abstract class SplashRepository {

}

class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource _remoteDataSource;

  SplashRepositoryImpl({
    required SplashRemoteDataSource splashRemoteDataSource,
  }) : _remoteDataSource = splashRemoteDataSource;

}
