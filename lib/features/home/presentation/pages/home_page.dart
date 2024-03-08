import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:ninjaz_task/core/injector.dart';
import 'package:ninjaz_task/features/home/data/models/post_model.dart';
import 'package:ninjaz_task/features/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:ninjaz_task/style/app_colors.dart';

import '../../../../shared_widget/empty_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = '/HomePage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().homeCubit..loadPosts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.isError) _showSnackBar(context, state.errorMessage);
      },
      builder: (context, state) {
        if (state.isInitial || state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final posts = state.posts;
        final homeCubit = context.read<HomeCubit>();

        if (posts?.isNotEmpty != true)
          return EmptyPage(
            message: 'No posts found!',
            onRefresh: homeCubit.refresh,
          );

        return LazyLoadScrollView(
          onEndOfPage: homeCubit.loadMorePosts,
          isLoading: state.isLoadingMore,
          child: RefreshIndicator(
            color: AppColors.SECONDARY_COLOR,
            onRefresh: homeCubit.refresh,
            child: _buildPostsList(posts!),
          ),
        );
      },
    );
  }

  Widget _buildPostsList(List<PostModel> list) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: list.length + 1,
      itemBuilder: (_, index) {
        if (index == list.length) return _buildPaginationLoading();
        final post = list[index];
        return ListTile(
          title: Text(post.owner?.firstName ?? ''),
          subtitle: Text(post.text ?? ''),
        );
      },
    );
  }

  Widget _buildPaginationLoading() {
    return Builder(
      builder: (context) => AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: context.watch<HomeCubit>().state.isLoadingMore
            ? const SizedBox(
                height: 15.0,
                child: FittedBox(
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.PRIMARY_COLOR,
      selectedItemColor: AppColors.SECONDARY_COLOR,
      onTap: (index) => _onTabChanged(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Posts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tab),
          label: 'Tab 2',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tab),
          label: 'Tab 3',
        ),
      ],
    );
  }

  void _onTabChanged(BuildContext context, int index) {
    if (index == 1 || index == 2) _showSnackBar(context, 'Coming soon!!');
  }

  void _showSnackBar(BuildContext context, String? message) {
    if (message == null) return;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.removeCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
