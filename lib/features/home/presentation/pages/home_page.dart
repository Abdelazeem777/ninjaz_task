import 'package:flutter/material.dart';
import 'package:ninjaz_task/style/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = '/HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBody() {
    return const Center(
      child: Text('Home Page'),
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
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.removeCurrentSnackBar();
    if (index == 1 || index == 2) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Coming soon!'),
        ),
      );
    }
  }
}
