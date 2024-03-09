import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ninjaz_task/core/exceptions/request_exception.dart';
import 'package:ninjaz_task/features/home/data/models/post_model.dart';
import 'package:ninjaz_task/features/home/data/repositories/home_repository.dart';
import 'package:ninjaz_task/features/home/presentation/cubits/home_cubit/home_cubit.dart';

class MockHomeRepo extends Mock implements HomeRepository {}

void main() {
  late HomeCubit cubit;
  late MockHomeRepo mockHomeRepo;
  setUp(() {
    mockHomeRepo = MockHomeRepo();
    cubit = HomeCubit(homeRepository: mockHomeRepo);
  });

  tearDown(() {
    cubit.close();
  });

  group('loadPosts', () {
    test(
      "Initial state should be HomeState(status: HomeStateStatus.initial)",
      () async {
        expect(
          cubit.state,
          const HomeState(status: HomeStateStatus.initial),
        );
      },
    );

    test('should emit loading and loaded (with posts) states when called',
        () async {
      //arrange
      when(() => mockHomeRepo.getPosts(limit: any(named: 'limit')))
          .thenAnswer((_) async => []);

      // assert later
      final expected = [
        const HomeState(status: HomeStateStatus.loading),
        const HomeState(status: HomeStateStatus.loaded, posts: []),
      ];
      expectLater(cubit.stream, emitsInOrder(expected));

      // act
      await cubit.loadPosts();
    });

    test('should emit loading and error states when called', () async {
      // arrange
      when(() => mockHomeRepo.getPosts(limit: any(named: 'limit')))
          .thenAnswer((_) async => throw RequestException('error'));

      // assert later
      final expected = [
        const HomeState(status: HomeStateStatus.loading),
        const HomeState(status: HomeStateStatus.error, errorMessage: 'error'),
      ];
      expectLater(cubit.stream, emitsInOrder(expected));

      // act
      await cubit.loadPosts();
    });
  });

  group('refresh', () {
    test('should emit loaded with the posts only without any exception',
        () async {
      //arrange
      when(() => mockHomeRepo.getPosts(limit: any(named: 'limit')))
          .thenAnswer((_) async => []);

      //assert later
      final expected = [
        const HomeState(status: HomeStateStatus.loaded, posts: []),
      ];
      expectLater(cubit.stream, emitsInOrder(expected));

      //act
      await cubit.refresh();
    });

    test('should emit error state when called', () async {
      // arrange
      when(() => mockHomeRepo.getPosts(limit: any(named: 'limit')))
          .thenAnswer((_) async => throw RequestException('error'));

      // assert later
      final expected = [
        const HomeState(status: HomeStateStatus.error, errorMessage: 'error'),
      ];
      expectLater(cubit.stream, emitsInOrder(expected));

      // act
      await cubit.refresh();
    });
  });

  group('loadMorePosts', () {
    final posts = List.generate(11, (i) => PostModel(id: '$i', likes: 0));
    test(
        'should emit loadingMore then loaded with (old posts + new posts) without any exception',
        () async {
      //arrange
      when(() => mockHomeRepo.getPosts(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
          )).thenAnswer((_) async => posts);
      cubit.emit(
          cubit.state.copyWith(status: HomeStateStatus.loaded, posts: posts));

      //assert later
      final expected = [
        HomeState(status: HomeStateStatus.loadingMore, posts: posts),
        HomeState(status: HomeStateStatus.loaded, posts: [...posts, ...posts]),
      ];
      expectLater(cubit.stream, emitsInOrder(expected));

      //act
      await cubit.loadMorePosts();
    });

    test('should emit error state when called', () async {
      // arrange
      when(() => mockHomeRepo.getPosts(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
          )).thenAnswer((_) async => throw RequestException('error'));
      cubit.emit(
          cubit.state.copyWith(status: HomeStateStatus.loaded, posts: posts));

      // assert later
      final expected = [
        HomeState(
          status: HomeStateStatus.loadingMore,
          posts: posts,
        ),
        HomeState(
          status: HomeStateStatus.error,
          errorMessage: 'error',
          posts: posts,
        ),
      ];
      expectLater(cubit.stream, emitsInOrder(expected));

      // act
      await cubit.loadMorePosts();
    });

    test(
        'should not emit loadingMore state when called if state is loadingMore',
        () async {
      //arrange
      cubit.emit(cubit.state
          .copyWith(status: HomeStateStatus.loadingMore, posts: posts));

      //act
      await cubit.loadMorePosts();

      //assert
      verifyNever(() => mockHomeRepo.getPosts(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
          ));
    });

    test(
        'should not emit loadingMore state when called if posts length is less than limit',
        () async {
      //arrange
      cubit.emit(cubit.state.copyWith(
        status: HomeStateStatus.loaded,
        posts: List.generate(9, (i) => PostModel(id: '$i', likes: 0)),
      ));

      //act
      await cubit.loadMorePosts();

      //assert
      verifyNever(() => mockHomeRepo.getPosts(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
          ));
    });
  });
}
