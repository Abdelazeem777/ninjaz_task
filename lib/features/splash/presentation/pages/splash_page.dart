import 'package:flutter/material.dart';
import 'package:ninjaz_task/style/app_colors.dart';

import '../../../home/presentation/pages/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static const routeName = '/SplashPage';

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => _navigateToHome(context));
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: Center(
        child: Image.asset('lib/assets/images/ninjaz_logo.png'),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }
}
