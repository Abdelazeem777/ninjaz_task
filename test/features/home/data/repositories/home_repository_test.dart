import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ninjaz_task/core/utils/connection_checker.dart';
import 'package:ninjaz_task/features/home/data/datasources/home_local_data_source.dart';
import 'package:ninjaz_task/features/home/data/datasources/home_remote_data_source.dart';
import 'package:ninjaz_task/features/home/data/models/post_model.dart';
import 'package:ninjaz_task/features/home/data/repositories/home_repository.dart';

class HomeRemoteDataSourceMock extends Mock implements HomeRemoteDataSource {}

class HomeLocalDataSourceMock extends Mock implements HomeLocalDataSource {}

class ConnectionCheckerMock extends Mock implements ConnectionChecker {}

void main() {
  late HomeRemoteDataSourceMock homeRemoteDataSourceMock;
  late HomeLocalDataSourceMock homeLocalDataSourceMock;
  late ConnectionCheckerMock connectionCheckerMock;
  late HomeRepository homeRepository;

  setUp(() {
    homeRemoteDataSourceMock = HomeRemoteDataSourceMock();
    homeLocalDataSourceMock = HomeLocalDataSourceMock();
    connectionCheckerMock = ConnectionCheckerMock();
    homeRepository = HomeRepositoryImpl(
      homeRemoteDataSource: homeRemoteDataSourceMock,
      homeLocalDataSource: homeLocalDataSourceMock,
      connectionChecker: connectionCheckerMock,
    );
  });

  group("getPosts", () {
    final posts = List.generate(
        5,
        (i) => PostModel(
            id: '$i',
            likes: i,
            tags: ['tag $i'],
            text: 'text $i',
            publishDate: DateTime(2021, 9, 1),
            owner: null));
    test(
        'should return list of PostModel when the response code is 200 and cache the posts when there is connection',
        () async {
      // arrange
      when(() => connectionCheckerMock.hasConnection())
          .thenAnswer((_) async => true);
      when(() => homeLocalDataSourceMock.cachePosts(posts))
          .thenAnswer((_) async {});
      when(() => homeRemoteDataSourceMock.getPosts()).thenAnswer(
        (_) async => posts,
      );
      when(() => homeRemoteDataSourceMock.getPosts()).thenAnswer(
        (_) async => posts,
      );
      // act
      final result = await homeRepository.getPosts();
      // assert
      expect(result, posts);
    });

    test('should return list of PostModel from local when no connection',
        () async {
      // arrange
      when(() => connectionCheckerMock.hasConnection())
          .thenAnswer((_) async => false);
      when(() => homeLocalDataSourceMock.getPosts()).thenAnswer(
        (_) async => posts,
      );
      // act
      final result = await homeRepository.getPosts();
      // assert
      expect(result, posts);
    });
  });
}
