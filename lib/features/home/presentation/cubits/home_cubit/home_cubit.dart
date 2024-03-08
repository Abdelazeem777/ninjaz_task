import 'package:flutter/foundation.dart';
import '../../../../../../core/abstract/base_cubit.dart';
import '../../../data/repositories/home_repository.dart';
part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit({
    required HomeRepository homeRepository,
  })  : _homeRepository = homeRepository,
        super(const HomeState());

  final HomeRepository _homeRepository;
}
