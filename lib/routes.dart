import 'package:flutter/material.dart';

import 'features/home/presentation/pages/home_page.dart';
import 'features/splash/presentation/pages/splash_page.dart';

final routes = {
  SplashPage.routeName: (BuildContext context) => const SplashPage(),
  HomePage.routeName: (BuildContext context) => const HomePage(),
};
