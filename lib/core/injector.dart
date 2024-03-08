import 'package:ninjaz_task/features/home/data/repositories/home_repository.dart';
import 'package:ninjaz_task/features/home/presentation/cubits/home_cubit/home_cubit.dart';

import '../features/home/data/datasources/home_local_data_source.dart';
import '../features/home/data/datasources/home_remote_data_source.dart';
import 'service/cache_service.dart';
import 'service/network_service.dart';

class Injector {
  static final Injector _singleton = Injector._internal();
  static Injector get instance => _singleton;

  final _flyweightMap = <Type, dynamic>{};

  Injector._internal();

  factory Injector() {
    return _singleton;
  }

  HomeCubit get homeCubit => HomeCubit(homeRepository: homeRepository);

  HomeRepository get homeRepository =>
      _flyweightMap[HomeRepository] ??= HomeRepositoryImpl(
        homeLocalDataSource: homeLocalDataSource,
        homeRemoteDataSource: homeRemoteDataSource,
      );

  // Data sources
  HomeLocalDataSource get homeLocalDataSource =>
      _flyweightMap[HomeLocalDataSource] ??=
          HomeLocalDataSourceImpl(cacheService);
  HomeRemoteDataSource get homeRemoteDataSource =>
      _flyweightMap[HomeRemoteDataSource] ??=
          HomeRemoteDataSourceImpl(networkService);

  // Services
  NetworkService get networkService =>
      _flyweightMap[NetworkService] ??= NetworkServiceImpl();
  CacheService get cacheService =>
      _flyweightMap[CacheService] ??= CacheServiceImpl();
}
