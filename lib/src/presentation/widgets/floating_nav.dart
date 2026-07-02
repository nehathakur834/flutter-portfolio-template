import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/responsive.dart';

class FloatingNav extends StatelessWidget {
  const FloatingNav({
    required this.labels,
    required this.onSelect,
    required this.isDark,
    required this.onToggleTheme,
    super.key,
  });

  final List<String> labels;
  final ValueChanged<String> onSelect;
  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 980),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Your Name',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                ),
                if (!isMobile)
                  for (final label in labels)
                    TextButton(
                      onPressed: () => onSelect(label),
                      child: Text(label),
                    ),
                IconButton(
                  tooltip: isDark ? 'Switch to light theme' : 'Switch to dark theme',
                  onPressed: onToggleTheme,
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: Icon(
                      isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      key: ValueKey(isDark),
                    ),
                  ),
                ),
                if (isMobile)
                  PopupMenuButton<String>(
                    tooltip: 'Sections',
                    onSelected: onSelect,
                    itemBuilder: (context) => [
                      for (final label in labels)
                        PopupMenuItem(value: label, child: Text(label)),
                    ],
                    icon: const Icon(Icons.menu_rounded),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
