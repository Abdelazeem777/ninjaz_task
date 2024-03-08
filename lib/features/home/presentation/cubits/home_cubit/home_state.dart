part of 'home_cubit.dart';

enum HomeStateStatus {
  initial,
  loading,
  loadingMore,
  loaded,
  error,
}

extension HomeStateX on HomeState {
  bool get isInitial => status == HomeStateStatus.initial;
  bool get isLoading => status == HomeStateStatus.loading;
  bool get isLoadingMore => status == HomeStateStatus.loadingMore;
  bool get isLoaded => status == HomeStateStatus.loaded;
  bool get isError => status == HomeStateStatus.error;
}

@immutable
class HomeState {
  final HomeStateStatus status;
  final String? errorMessage;
  final List<PostModel>? posts;

  const HomeState({
    this.status = HomeStateStatus.initial,
    this.errorMessage,
    this.posts,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as HomeState).status == status &&
        other.errorMessage == errorMessage &&
        listEquals(other.posts, posts);
  }

  @override
  int get hashCode =>
      status.hashCode ^ errorMessage.hashCode ^ Object.hashAll(posts ?? []);

  HomeState copyWith({
    HomeStateStatus? status,
    String? errorMessage,
    List<PostModel>? posts,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      posts: posts ?? this.posts,
    );
  }
}
