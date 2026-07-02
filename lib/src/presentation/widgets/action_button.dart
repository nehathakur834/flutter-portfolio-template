import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.filled = true,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool filled;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final foreground = widget.filled ? Colors.white : scheme.primary;
    final background = widget.filled ? scheme.primary : scheme.primary.withValues(alpha: .10);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _hovered ? 1.035 : 1,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: FilledButton.icon(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon, size: 18),
          label: Text(widget.label, maxLines: 1, overflow: TextOverflow.ellipsis),
          style: FilledButton.styleFrom(
            elevation: 0,
            foregroundColor: foreground,
            backgroundColor: background,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }
}
