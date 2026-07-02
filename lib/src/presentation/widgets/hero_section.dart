import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../core/responsive.dart';
import 'action_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({
    required this.onViewProjects,
    required this.onContact,
    super.key,
  });

  final VoidCallback onViewProjects;
  final VoidCallback onContact;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, .06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Padding(
          padding: EdgeInsets.only(top: isMobile ? 28 : 64, bottom: 80),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: isMobile ? 0 : 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Senior Flutter Developer | 9+ years',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text('Your\nName', style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: 22),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: Text(
                        'I design and build AI-powered Flutter apps with scalable architecture, polished interfaces, and launch-ready product thinking.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ActionButton(
                          label: 'View Projects',
                          icon: Icons.workspaces_rounded,
                          onPressed: widget.onViewProjects,
                        ),
                        ActionButton(
                          label: 'Contact Me',
                          icon: Icons.mail_rounded,
                          onPressed: widget.onContact,
                          filled: false,
                        ),
                        ActionButton(
                          label: 'Download Resume',
                          icon: Icons.download_rounded,
                          onPressed: () {},
                          filled: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: isMobile ? 0 : 42, height: isMobile ? 38 : 0),
              Expanded(
                flex: isMobile ? 0 : 5,
                child: const _ProfileShowcase(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileShowcase extends StatelessWidget {
  const _ProfileShowcase();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 1100),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 18 * (1 - value)),
            child: Opacity(opacity: value, child: child),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppTheme.mint, AppTheme.sky, AppTheme.coral],
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.mint.withValues(alpha: .22),
                blurRadius: 44,
                offset: const Offset(0, 26),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: .78),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withValues(alpha: .34)),
              ),
              child: CustomPaint(
                painter: _ProfilePainter(isDark: Theme.of(context).brightness == Brightness.dark),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfilePainter extends CustomPainter {
  const _ProfilePainter({required this.isDark});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * .5, size.height * .42);
    final skin = Paint()..color = const Color(0xFFEFC6A8);
    final hair = Paint()..color = isDark ? const Color(0xFF111827) : const Color(0xFF2F2A2A);
    final accent = Paint()..color = AppTheme.mint;
    final coral = Paint()..color = AppTheme.coral;
    final line = Paint()
      ..color = isDark ? Colors.white70 : AppTheme.ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(Offset(size.width * .70, size.height * .20), size.width * .06, accent);
    canvas.drawCircle(Offset(size.width * .22, size.height * .72), size.width * .035, coral);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * .18, size.height * .62, size.width * .64, size.height * .18),
        const Radius.circular(8),
      ),
      Paint()..color = AppTheme.violet.withValues(alpha: .18),
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(center.dx, center.dy - size.height * .02), width: size.width * .42, height: size.height * .48),
      hair,
    );
    canvas.drawCircle(center, size.width * .17, skin);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * .34, size.height * .38)
        ..quadraticBezierTo(size.width * .50, size.height * .18, size.width * .68, size.height * .37),
      hair,
    );
    canvas.drawLine(Offset(size.width * .43, size.height * .43), Offset(size.width * .45, size.height * .43), line);
    canvas.drawLine(Offset(size.width * .56, size.height * .43), Offset(size.width * .58, size.height * .43), line);
    canvas.drawArc(
      Rect.fromCenter(center: Offset(size.width * .51, size.height * .51), width: size.width * .14, height: size.height * .08),
      0,
      3.14,
      false,
      line,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * .31, size.height * .60, size.width * .38, size.height * .24),
        const Radius.circular(8),
      ),
      Paint()..color = AppTheme.mint.withValues(alpha: .72),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * .38, size.height * .68, size.width * .24, size.height * .08),
        const Radius.circular(8),
      ),
      Paint()..color = Colors.white.withValues(alpha: .22),
    );
  }

  @override
  bool shouldRepaint(covariant _ProfilePainter oldDelegate) => oldDelegate.isDark != isDark;
}
