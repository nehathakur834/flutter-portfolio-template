import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/portfolio_models.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({required this.project, super.key});

  final Project project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  Future<void> _copyLink(String url) async {
    await Clipboard.setData(ClipboardData(text: url));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $url'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, _hovered ? -8.0 : 0.0),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovered ? project.accent.withValues(alpha: .72) : Theme.of(context).dividerColor,
          ),
          boxShadow: [
            BoxShadow(
              color: project.accent.withValues(alpha: _hovered ? .18 : .08),
              blurRadius: _hovered ? 42 : 24,
              offset: Offset(0, _hovered ? 24 : 16),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _ProjectScreenshot(project: project, hovered: _hovered),
            ),
            const SizedBox(height: 18),
            Text(project.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(
              project.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final tag in project.stack)
                  _Tag(label: tag, color: project.accent),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _copyLink(project.githubUrl),
                    icon: const Icon(Icons.code_rounded, size: 17),
                    label: const Text('GitHub'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _copyLink(project.demoUrl),
                    icon: const Icon(Icons.open_in_new_rounded, size: 17),
                    label: const Text('Live Demo'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectScreenshot extends StatelessWidget {
  const _ProjectScreenshot({required this.project, required this.hovered});

  final Project project;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              project.accent.withValues(alpha: hovered ? .95 : .72),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: CustomPaint(
          painter: _ScreenshotPainter(
            accent: project.accent,
            isDark: Theme.of(context).brightness == Brightness.dark,
            seed: project.title.length,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _Dot(color: Colors.redAccent.withValues(alpha: .9)),
                    const SizedBox(width: 6),
                    _Dot(color: Colors.amber.withValues(alpha: .9)),
                    const SizedBox(width: 6),
                    _Dot(color: Colors.greenAccent.withValues(alpha: .9)),
                  ],
                ),
                const Spacer(),
                for (final metric in project.metrics.take(2)) ...[
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .18),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withValues(alpha: .24)),
                    ),
                    child: Text(
                      metric,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScreenshotPainter extends CustomPainter {
  const _ScreenshotPainter({
    required this.accent,
    required this.isDark,
    required this.seed,
  });

  final Color accent;
  final bool isDark;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()..color = Colors.white.withValues(alpha: .16);
    final faint = Paint()..color = Colors.white.withValues(alpha: .10);
    final strong = Paint()..color = accent.withValues(alpha: .62);
    final dark = Paint()..color = (isDark ? Colors.black : Colors.white).withValues(alpha: .18);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * .09, size.height * .20, size.width * .74, size.height * .18),
        const Radius.circular(8),
      ),
      base,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * .14, size.height * .26, size.width * .48, size.height * .04),
        const Radius.circular(8),
      ),
      dark,
    );
    for (var i = 0; i < 4; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width * (.10 + i * .19),
            size.height * (.48 + (i.isEven ? .02 : 0)),
            size.width * .14,
            size.height * (.16 + ((seed + i) % 2) * .05),
          ),
          const Radius.circular(8),
        ),
        i.isEven ? strong : faint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ScreenshotPainter oldDelegate) {
    return oldDelegate.accent != accent || oldDelegate.isDark != isDark || oldDelegate.seed != seed;
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
