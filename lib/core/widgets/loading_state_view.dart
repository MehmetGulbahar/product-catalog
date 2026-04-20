import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

class LoadingStateView extends StatelessWidget {
  final String message;

  const LoadingStateView({super.key, this.message = 'Loading products...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 28,
            width: 28,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(message, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
