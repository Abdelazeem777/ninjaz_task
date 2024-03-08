import 'package:flutter/foundation.dart';
import '../../../../../../core/abstract/base_cubit.dart';
import '../../../data/models/post_model.dart';
import '../../../data/repositories/home_repository.dart';
part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit({
    required HomeRepository homeRepository,
  })  : _homeRepository = homeRepository,
        super(const HomeState());

  final HomeRepository _homeRepository;

  static const _postsLimit = 10;

  Future<void> loadPosts([bool refresh = false]) async {
    try {
      if (!refresh) emit(state.copyWith(status: HomeStateStatus.loading));
      final posts = await _homeRepository.getPosts(limit: _postsLimit);
      emit(state.copyWith(
        status: HomeStateStatus.loaded,
        posts: posts,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> refreshPosts() => loadPosts(true);

  Future<void> loadMoreEvents() async {
    if (state.isLoadingMore) return;
    if ((state.posts ?? []).length < _postsLimit) return;

    try {
      emit(state.copyWith(status: HomeStateStatus.loadingMore));

      final newPosts = await _homeRepository.getPosts(
        page: (state.posts?.length ?? 0) ~/ _postsLimit,
        limit: _postsLimit,
      );

      emit(
        state.copyWith(
          status: HomeStateStatus.loaded,
          posts: [...?state.posts, ...newPosts],
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: HomeStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
