import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ninjaz_task/features/home/data/datasources/home_local_data_source.dart';
import 'package:ninjaz_task/features/home/data/datasources/home_remote_data_source.dart';
import 'package:ninjaz_task/features/home/data/models/post_model.dart';
import 'package:ninjaz_task/features/home/data/repositories/home_repository.dart';

class HomeRemoteDataSourceMock extends Mock implements HomeRemoteDataSource {}

class HomeLocalDataSourceMock extends Mock implements HomeLocalDataSource {}

void main() {
  late HomeRemoteDataSourceMock homeRemoteDataSourceMock;
  late HomeLocalDataSourceMock homeLocalDataSourceMock;
  late HomeRepository homeRepository;

  setUp(() {
    homeRemoteDataSourceMock = HomeRemoteDataSourceMock();
    homeLocalDataSourceMock = HomeLocalDataSourceMock();
    homeRepository = HomeRepositoryImpl(
      homeRemoteDataSource: homeRemoteDataSourceMock,
      homeLocalDataSource: homeLocalDataSourceMock,
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
            publishDate: '2021-09-01',
            owner: null));
    test('should return list of PostModel when the response code is 200',
        () async {
      // arrange
      when(() => homeRemoteDataSourceMock.getPosts()).thenAnswer(
        (_) async => posts,
      );
      // act
      final result = await homeRepository.getPosts();
      // assert
      expect(result, posts);
    });
  });
}
