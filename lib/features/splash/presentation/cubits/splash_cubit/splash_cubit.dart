
import 'package:flutter/foundation.dart';
import '../../../../../../core/abstract/base_cubit.dart';
import '../../../data/repositories/splash_repository.dart';
part 'splash_state.dart';

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit({
    required SplashRepository splashRepository,
  })  : _splashRepository = splashRepository,
        super(const SplashState());

  final SplashRepository _splashRepository;
  

  
    }
  

