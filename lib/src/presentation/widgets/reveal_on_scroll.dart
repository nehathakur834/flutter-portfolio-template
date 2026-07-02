import 'package:flutter/material.dart';

class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    required this.child,
    required this.controller,
    super.key,
  });

  final Widget child;
  final ScrollController controller;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> with SingleTickerProviderStateMixin {
  late final AnimationController _animation;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 680),
    );
    _fade = CurvedAnimation(parent: _animation, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, .08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animation, curve: Curves.easeOutCubic));
    widget.controller.addListener(_checkVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void didUpdateWidget(covariant RevealOnScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_checkVisibility);
      widget.controller.addListener(_checkVisibility);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkVisibility);
    _animation.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (_revealed || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final offset = box.localToGlobal(Offset.zero);
    final height = MediaQuery.sizeOf(context).height;
    if (offset.dy < height * .86) {
      _revealed = true;
      _animation.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
