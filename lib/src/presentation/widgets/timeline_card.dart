import 'package:flutter/material.dart';

import '../../domain/portfolio_models.dart';

class TimelineCard extends StatelessWidget {
  const TimelineCard({
    required this.entry,
    required this.isLast,
    super.key,
  });

  final TimelineEntry entry;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            child: Column(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primary.withValues(alpha: .35),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 18),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.period,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: primary),
                  ),
                  const SizedBox(height: 8),
                  Text(entry.title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(entry.description, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
