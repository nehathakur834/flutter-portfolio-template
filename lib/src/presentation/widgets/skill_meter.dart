import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../domain/portfolio_models.dart';
import 'reveal_on_scroll.dart';

class SkillMeter extends StatelessWidget {
  const SkillMeter({
    required this.skill,
    required this.controller,
    super.key,
  });

  final Skill skill;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final width = Responsive.isMobile(context) ? double.infinity : 360.0;

    return SizedBox(
      width: width,
      child: RevealOnScroll(
        controller: controller,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(skill.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
                  ),
                  Text('${(skill.value * 100).round()}%', style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
              const SizedBox(height: 14),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: skill.value),
                duration: const Duration(milliseconds: 1100),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 10,
                      backgroundColor: skill.color.withValues(alpha: .13),
                      valueColor: AlwaysStoppedAnimation<Color>(skill.color),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
