import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../style/app_colors.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    super.key,
    String? message,
    AsyncCallback? onRefresh,
  })  : _message = message,
        _onRefresh = onRefresh;

  final String? _message;
  final AsyncCallback? _onRefresh;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    Widget child = SizedBox(
      height: screenHeight * 0.8,
      child: Center(
        child: Text(_message ?? 'No data found!'),
      ),
    );

    if (_onRefresh != null)
      child = RefreshIndicator(
        color: AppColors.SECONDARY_COLOR,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: child,
        ),
      );

    return child;
  }
}
