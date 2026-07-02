import 'package:flutter/material.dart';

import '../../core/app_theme.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [AppTheme.night, Color(0xFF141821), Color(0xFF0F1419)]
              : const [AppTheme.paper, Color(0xFFF1FBF9), Color(0xFFFFF7F3)],
        ),
      ),
      child: child,
    );
  }
}
